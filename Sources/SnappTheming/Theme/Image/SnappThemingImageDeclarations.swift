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
    /// - Parameter keyPath: The key path used to identify the desired image.
    /// - Returns: The resolved image, or the fallback image if the resolution fails.
    public subscript(dynamicMember keyPath: String) -> Image {
        guard
            let rawValue: String = self[dynamicMember: keyPath]
        else {
            os_log(.error, "Error resolving image with name: %@.", keyPath)
            return configuration.fallbackImage
        }

        if let representation = try? SnappThemingDataURI(from: rawValue) {
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
        } else if rawValue.starts(with: "system:") {
            return Image(systemName: rawValue.removingPrefix(separator: ":"))
        } else if rawValue.starts(with: "asset:") {
            return Image(rawValue.removingPrefix(separator: ":"))
        }

        return configuration.fallbackImage
    }
}
