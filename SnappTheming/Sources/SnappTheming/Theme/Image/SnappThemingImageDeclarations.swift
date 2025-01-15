//
//  SnappThemingImageDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import SwiftUI
import OSLog

/// Manages image tokens. Supports bitmap assets for different scenarios.
public typealias SnappThemingImageDeclarations = SnappThemingDeclarations<SnappThemingDataURI, SnappThemingImageConfiguration>

/// Configuration for handling themed images in a SnappTheming framework.
public struct SnappThemingImageConfiguration {
    /// Fallback image to use when a specific image cannot be resolved.
    public let fallbackImage: Image

    /// Manager for handling image caching and retrieval.
    public let imagesManager: SnappThemingImageManager
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingDataURI, Configuration == SnappThemingImageConfiguration {
    /// Initializes the declarations for themed images.
    /// - Parameters:
    ///   - cache: A cache of image tokens keyed by their identifiers.
    ///   - configuration: The parser configuration used to define fallback and manager behavior.
    public init(cache: [String: SnappThemingToken<SnappThemingDataURI>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .images,
            configuration: SnappThemingImageConfiguration(
                fallbackImage: configuration.fallbackImage,
                imagesManager: .init(
                    themeCacheRootURL: configuration.themeCacheRootURL,
                    themeName: configuration.themeName
                )
            )
        )
    }

    /// Dynamically resolves an image using a key path.
    /// - Parameter keyPath: The key path used to identify the desired image.
    /// - Returns: The resolved image, or the fallback image if the resolution fails.
    public subscript(dynamicMember keyPath: String) -> Image {
        guard let representation: SnappThemingDataURI = self[dynamicMember: keyPath] else {
            os_log(.error, "Error resolving image with name: %@.", keyPath)
            return configuration.fallbackImage
        }

        let cachedImage = configuration.imagesManager
            .object(for: keyPath, of: representation) { data, uri in
                image(from: SnappThemingDataURI(
                    type: uri.type,
                    encoding: representation.encoding,
                    data: data
                ))
            }
        let uiImage: UIImage? = cachedImage ?? image(from: representation)

        if let uiImage {
            configuration.imagesManager.setObject(uiImage, for: keyPath)
            configuration.imagesManager.store(representation, for: keyPath)
            return Image(uiImage: uiImage)
        }

        return configuration.fallbackImage
    }

    private func image(from representation: SnappThemingDataURI) -> UIImage? {
        switch representation.type {
        case .pdf:
                .pdf(data: representation.data)
        case .png, .jpeg:
            UIImage(data: representation.data)
        default:
            SnappThemingImageProcessorsRegistry
                .shared
                .registeredConverters()
                .compactMap { $0.converte(representation) }
                .first
        }
    }
}
