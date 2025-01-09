//
//  SnappThemingColorDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import SwiftUI

/// Responsible for managing and resolving color tokens. This includes static colors and dynamic system colors, supporting light/dark mode.
public typealias SnappThemingColorDeclarations = SnappThemingDeclarations<SnappThemingColorRepresentation, SnappThemingColorConfiguration>

/// A structure representing the configuration for theming colors in the Snapp application.
///
/// - `fallbackColor`: The default color to use if no matching color is found in the configuration.
/// - `colorFormat`: Specifies the format in which colors are represented (e.g., hex, dynamic, etc.).
///
/// This structure is designed to help configure colors that will be used across the app, with a fallback in case of missing or incorrect values.
public struct SnappThemingColorConfiguration {
    /// The default color to fall back to when a color is not available in the theme.
    public let fallbackColor: Color

    /// The format of the color (ARGB or RGBA).
    public let colorFormat: SnappThemingColorFormat
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingColorRepresentation, Configuration == SnappThemingColorConfiguration {
    /// Initializes a `SnappThemingDeclarations` object for colors, optionally using a cached color representation.
    ///
    /// - Parameters:
    ///   - cache: A dictionary of cached color representations keyed by their identifiers.
    ///   - configuration: A configuration object that defines the fallback color and color format. Defaults to `.default`.
    ///
    /// - This initializer allows the creation of color declarations using pre-defined fallback values and color format configuration.
    public init(cache: [String: SnappThemingToken<SnappThemingColorRepresentation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .colors,
            configuration: .init(
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
        guard let representation: SnappThemingColorRepresentation = self[dynamicMember: keyPath] else {
            return configuration.fallbackColor
        }
        return representation.color(using: configuration.colorFormat)
    }

    /// Accesses a color by its dynamic key path, returning a `UIColor` value.
    ///
    /// - Parameter keyPath: The key path of the color to fetch.
    /// - Returns: The corresponding `UIColor` value if found, or `.clear` if not found.
    public subscript(dynamicMember keyPath: String) -> UIColor {
        guard let representation: SnappThemingColorRepresentation = self[dynamicMember: keyPath] else {
            // TODO: Pick from configuration
            return .clear
        }
        return representation.uiColor(using: configuration.colorFormat)
    }
}

extension SnappThemingColorRepresentation {
    func color(using format: SnappThemingColorFormat) -> Color {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.color(using: format)
        case let .hex(hexValue):
            Color(hex: hexValue, format: format)
        }
    }

    func uiColor(using format: SnappThemingColorFormat) -> UIColor {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.uiColor(using: format)
        case let .hex(hexValue):
            UIColor(hex: hexValue, format: format)
        }
    }
}
