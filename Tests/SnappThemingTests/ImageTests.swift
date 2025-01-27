//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SwiftUI
import Testing
import UIKit

@testable import SnappTheming

@Suite
struct ImageTests {
    @Test
    func parsePNGImage() throws {
        let json =
            """
            {
                "images": {
                    "basket": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAABdUlEQVR42u2VIUhDURSGvycMy6KI4CxOsFiFgUbBMqsmwSpYBatgmcFkEgyCbjPYFItiVrAKYhlsb5Y3sQ3E7QlywuaF59279wiK36nnOwfez7kPioTEXyqkiDcaxJhVJ1BbIDWFH+QTmbWCEiVZUEKJZVlwjRJ5WfBKgAoBLVmRR4mrn4p5Vztm9wopJsTspRpgEvDibUGUHLN73WjFvCMT9rSu+UImrGpdcygTZhKu2eHRHhW7TUbnmhfFvtO65i2xD7Qe7VOx17Ue7UexCwD+Y87S+TQ7ZHUe7TkxH7Qe7Q0xy1r/5kMxN0lkMnXM92IuAPiPOUNbvBHbf/Mag1AQq25/jzVmGcKOaW7FOuJbxngjTl3zWLCdenwVKwL26aYYf87wIKGd8cS71eAuNS5Z4p9fxQRVmjSpkPPRayotYqmInGuvSZW4p8quvSbNPunZoddKarj2mlT6pGPXXpMcUU9w4z56Ta1MSMiJKJa9f+lSPwAZoy76GuY93wAAAABJRU5ErkJggg=="
                }
            }
            """

        let imageManager = SnappThemingImageManagerMock()
        let fallbackUIImage = try #require(UIImage(systemName: "square"))
        let fallbackImage = Image(uiImage: fallbackUIImage)
        let configuration = SnappThemingParserConfiguration(
            fallbackImage: fallbackImage,
            imageManager: imageManager
        )

        let declaration = try SnappThemingParser.parse(from: json, using: configuration)
        let imageData: SnappThemingDataURI = try #require(declaration.images.basket)
        let image: Image = declaration.images.basket
        #expect(imageData.type == .png)
        #expect(image != fallbackImage)
        let representation = try #require(imageManager.cache.object(forKey: "basket"))
        #expect(representation.cgImage != fallbackUIImage.cgImage)
    }
}
