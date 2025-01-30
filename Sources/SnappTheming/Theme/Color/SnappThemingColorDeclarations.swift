//
//  SnappThemingColorDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
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

    /// Accesses a color by its dynamic key path, returning a `Color` value.
    ///
    /// - Parameter keyPath: The key path of the color to fetch.
    /// - Returns: The corresponding color value if found, or the `fallbackColor` if not found.
    public subscript(dynamicMember keyPath: String) -> Color {
        guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
            return configuration.fallbackColor
        }
        return representation.color(using: configuration.colorFormat)
    }

    #if canImport(UIKit)
        /// Accesses a color by its dynamic key path, returning a `UIColor` value.
        ///
        /// - Parameter keyPath: The key path of the color to fetch.
        /// - Returns: The corresponding `UIColor` value if found, or `.clear` if not found.
        public subscript(dynamicMember keyPath: String) -> UIColor {
            guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
                return configuration.fallbackUIColor
            }
            return representation.uiColor(using: configuration.colorFormat)
        }
    #endif
}
