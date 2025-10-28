//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SwiftUI
import Testing

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
        let fallbackThemingImage = try #require(SnappThemingImage.system("square"))
        let fallbackImage = fallbackThemingImage.image
        let configuration = SnappThemingParserConfiguration(
            fallbackImage: fallbackImage,
            imageManager: imageManager
        )

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let rawData: String = try #require(
            declaration.images.basket)
        let imageData = try #require(try? SnappThemingDataURI(from: rawData))
        let image: Image = declaration.images.basket
        #expect(imageData.type == .png)
        #expect(image != fallbackImage)
        let representation = try #require(
            imageManager.cache.object(forKey: "basket") as? Data)
        #expect(SnappThemingImage(data: representation) != fallbackThemingImage)
    }

    @Test
    func parseSFSymbol() throws {
        let json =
            """
            {
                "images": {
                    "warning": "system:exclamationmark.triangle"
                }
            }
            """

        let imageManager = SnappThemingImageManagerMock()
        let expectedImage = Image(systemName: "exclamationmark.triangle")
        let fallbackThemeImage = try #require(SnappThemingImage.system("square"))
        let fallbackImage = fallbackThemeImage.image
        let configuration = SnappThemingParserConfiguration(
            fallbackImage: fallbackImage,
            imageManager: imageManager
        )

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)

        let image: Image = declaration.images.warning
        #expect(image == expectedImage)
        #expect(image != fallbackImage)
    }

    @Test
    func useFallbackImageIfMissing() throws {
        let fallbackThemeImage = try #require(SnappThemingImage.system("square"))
        let fallbackImage = fallbackThemeImage.image
        let configuration = SnappThemingParserConfiguration(
            fallbackImage: fallbackImage)
        let declaration = try SnappThemingParser.parse(
            from: "{}", using: configuration)

        let rawData: String? = declaration.images.cache["basket"]?.value
        let image: Image = declaration.images.basket

        #expect(rawData == nil)
        #expect((image == fallbackImage))
    }

    @Test
    func useFallbackImageIfBrokenData() throws {
        let json =
            """
            {
                "images": {
                    "basket": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAABdUlEQVR42u2VIUhDURSGvycMy6KI4CxOsFiFgUbBMqsmwSpYBatgmcFkEgyCbjPYFItiVrAKYhlsb5Y3sQ3E7QlywuaF59279wiK36nnOwfez7kPioTEXyqkiDcaxJhVJ1BbIDWFH+QTmbWCEiVZUEKJZVlwjRJ5WfBKgAoBLVmRR4mrn4p5Vztm9wopJsTspRpgEvDibUGUHLN73WjFvCMT9rSu+UImrGpdcygTZhKu2eHRHhW7TUbnmhfFvtO65i2xD7Qe7VOx17Ue7UexCwD+Y87S+TQ7ZHUe7TkxH7Qe7Q0xy1r/5kMxN0lkMnXM92IuAPiPOUNbvBHbf/Mag1AQq25/jzVmGcKOaW7FOuJbxngjTl3zWLCdenwVKwL26aYYf87wIKGd8cS71eAuNS5Z4p9fxQRVmjSpkPPRayotYqmInGuvSZW4p8quvSbNPunZoddKarj2mlT6pGPXXpMcUU9w4z56Ta1MSMiJKJa9f+lSPwAZoy76GuY93wAAAABJRU5ErkJggg=="
                }
            }
            """

        let imageManager = SnappThemingImageManagerMock(image: { _, _ in nil
        })
        let fallbackThemeImage = try #require(SnappThemingImage.system("square"))
        let fallbackImage = fallbackThemeImage.image
        let configuration = SnappThemingParserConfiguration(
            fallbackImage: fallbackImage,
            imageManager: imageManager
        )

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)

        let rawData: String = try #require(
            declaration.images.basket)
        let _ = try SnappThemingDataURI(from: rawData)
        let image: Image = declaration.images.basket

        #expect(image == fallbackImage)
    }
}
