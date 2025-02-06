//
//  SnappThemingColorDeclarations.swift
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

public typealias SnappThemingColorDeclarations = SnappThemingDeclarations<
    SnappThemingColorRepresentation,
    SnappThemingColorConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingColorRepresentation,
    Configuration == SnappThemingColorConfiguration
{
    /// Initializes a `SnappThemingDeclarations` object for colors, optionally using a cached color representation.
    ///
    /// - Parameters:
    ///   - cache: A dictionary of cached color representations keyed by their identifiers.
    ///   - configuration: A configuration object that defines the fallback color and color format. Defaults to `.default`.
    ///
    /// - This initializer allows the creation of color declarations using pre-defined fallback values and color format configuration.
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(
            cache: cache,
            rootKey: .colors,
            configuration: Configuration(
                fallbackColor: configuration.fallbackColor,
                colorFormat: configuration.colorFormat
            )
        )
    }

    /// Retrieves a `Color` value using a dynamic key path.
    ///
    /// - Parameter keyPath: The key path of the color to fetch.
    /// - Returns: The corresponding `Color` value if found, or the fallback color if not found.
    public subscript(dynamicMember keyPath: String) -> Color {
        guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
            os_log(.error, "Failed to lookup Color for dynamic member '%{public}@", keyPath)
            return configuration.fallbackColor
        }
        return representation.color(using: configuration.colorFormat)
    }

    #if canImport(UIKit)
        /// Retrieves a `UIColor` value using a dynamic key path.
        ///
        /// - Parameter keyPath: The key path of the color to fetch.
        /// - Returns: The corresponding `UIColor` value if found, or the fallback color if not found.
        public subscript(dynamicMember keyPath: String) -> UIColor {
            guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
                os_log(.error, "Failed to lookup UIColor for dynamic member '%{public}@'", keyPath)
                return configuration.fallbackUIColor
            }
            return representation.uiColor(using: configuration.colorFormat)
        }
    #elseif canImport(AppKit)
        /// Retrieves an `NSColor` value using a dynamic key path.
        ///
        /// - Parameter keyPath: The key path of the color to fetch.
        /// - Returns: The corresponding `NSColor` value if found, or the fallback color if not found.
        public subscript(dynamicMember keyPath: String) -> NSColor {
            guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
                os_log(.error, "Failed to lookup NSColor for dynamic member '%{public}@'", keyPath)
                return configuration.fallbackNSColor
            }
            return representation.nsColor(using: configuration.colorFormat)
        }
    #endif
}
