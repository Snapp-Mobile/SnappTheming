//
//  SAThemingImageDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import SwiftUI
import OSLog

public typealias SAThemingImageDeclarations = SAThemingDeclarations<SAThemingDataURI, SAThemingImageConfiguration>

public struct SAThemingImageConfiguration {
    public let fallbackImage: Image
    public let imagesManager: SAThemingImagesManager

}

extension SAThemingDeclarations where DeclaredValue == SAThemingDataURI, Configuration == SAThemingImageConfiguration {
    public init(cache: [String: SAThemingToken<SAThemingDataURI>]?, configuration: SAThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .images,
            configuration: .init(
                fallbackImage: configuration.fallbackImage,
                imagesManager: .init(
                    themeCacheRootURL: configuration.themeCacheRootURL,
                    themeName: configuration.themeName
                )
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> Image {
        guard let representation: SAThemingDataURI = self[dynamicMember: keyPath] else {
            os_log(.error, "Error resolving image with name: %@.", keyPath)
            return configuration.fallbackImage
        }

        let cachedImage = configuration.imagesManager.object(for: keyPath, of: representation)
        let uiImage: UIImage? = cachedImage ?? .from(representation)

        if let uiImage {
            configuration.imagesManager.setObject(uiImage, for: keyPath)
            configuration.imagesManager.store(representation, for: keyPath)
            return Image(uiImage: uiImage)
        }

        return configuration.fallbackImage
    }
}
