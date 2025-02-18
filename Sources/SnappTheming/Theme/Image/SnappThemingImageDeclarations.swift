//
//  SnappThemingImageDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import OSLog
import SwiftUI

#if canImport(UIKit)
    import UIKit
#endif
#if canImport(AppKit)
    import AppKit
#endif

public typealias SnappThemingImageDeclarations = SnappThemingDeclarations<
    SnappThemingDataURI,
    SnappThemingImageConfiguration
>

extension SnappThemingDeclarations
where DeclaredValue == SnappThemingDataURI, Configuration == SnappThemingImageConfiguration {
    /// Initializes the declarations for themed images.
    /// - Parameters:
    ///   - cache: A cache of image tokens keyed by their identifiers.
    ///   - configuration: The parser configuration used to define fallback and manager behavior.
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
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
    /// - Parameter keyPath: The key path used to identify the desired image.
    /// - Returns: The resolved image, or the fallback image if the resolution fails.
    public subscript(dynamicMember keyPath: String) -> Image {
        guard
            let representation: DeclaredValue = self[dynamicMember: keyPath]
        else {
            runtimeWarning(#file, #line, "Failed resolving image with name: \(keyPath).")
            return configuration.fallbackImage
        }

        let cachedData = configuration.imagesManager.object(for: keyPath, of: representation) ?? representation.data
        #if canImport(UIKit)
            if let uiImage = configuration.imagesManager.image(from: cachedData, of: representation.type) {
                configuration.imagesManager.setObject(representation.data, for: keyPath)
                configuration.imagesManager.store(representation, for: keyPath)
                return Image(uiImage: uiImage)
            }
        #elseif canImport(AppKit)
            if let nsImage = configuration.imagesManager.image(from: cachedData, of: representation.type) {
                configuration.imagesManager.setObject(representation.data, for: keyPath)
                configuration.imagesManager.store(representation, for: keyPath)
                return Image(nsImage: nsImage)
            }
        #endif

        return configuration.fallbackImage
    }
}
