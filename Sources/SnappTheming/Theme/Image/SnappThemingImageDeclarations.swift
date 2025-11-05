//
//  SnappThemingImageDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import OSLog
import SwiftUI

public typealias SnappThemingImageDeclarations = SnappThemingDeclarations<
    String,
    SnappThemingImageConfiguration
>

extension SnappThemingDeclarations
where DeclaredValue == String, Configuration == SnappThemingImageConfiguration {
    /// Initializes the declarations for themed images.
    /// - Parameters:
    ///   - cache: A cache of image tokens keyed by their identifiers.
    ///   - configuration: The parser configuration used to define fallback and manager behavior.
    public init(
        cache: [String: SnappThemingToken<String>]?,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(
            cache: cache,
            rootKey: .images,
            configuration: Configuration(
                fallbackImage: configuration.fallbackImage,
                imagesManager: configuration.imageManager
                    ?? SnappThemingImageManagerDefault(
                        themeCacheRootURL: configuration.themeCacheRootURL,
                        themeName: configuration.themeName
                    )
            )
        )
    }

    /// Dynamically resolves an image using a key path.
    ///
    /// This subscript attempts to retrieve an image representation based on the given key path.
    /// If the resolution fails, a runtime warning is logged, and a fallback image is returned.
    ///
    /// - Parameter keyPath: The key path used to identify the desired image.
    /// - Returns: The resolved image if found; otherwise, the fallback image.
    public subscript(dynamicMember keyPath: String) -> Image {
        guard
            let rawValue: String = self[dynamicMember: keyPath]
        else {
            runtimeWarning("Failed resolving image with name: \(keyPath).")
            return configuration.fallbackImage
        }

        if let representation = try? SnappThemingDataURI(from: rawValue) {
            let imageObject = configuration.imagesManager.object(for: keyPath, of: representation)
            let cachedData = imageObject.0 ?? representation.data
            configuration.imagesManager.setObject(representation.data, for: keyPath)
            configuration.imagesManager.store(representation, for: keyPath)
            if let themingImage = configuration.imagesManager.image(from: cachedData, url: imageObject.1, of: representation.type) {
//                if let storedImage = configuration.imagesManager.image(from: cachedData, url: imageObject.1, of: representation.type) {
                    return themingImage.image
//                }
            }
        } else if rawValue.starts(with: "system:") {
            return Image(systemName: rawValue.removingPrefix(separator: ":"))
        } else if rawValue.starts(with: "asset:") {
            return Image(rawValue.removingPrefix(separator: ":"))
        }

        return configuration.fallbackImage
    }
}
