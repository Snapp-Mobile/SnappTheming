//
//  SnappThemingDynamicColor.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

/// A struct representing a dynamic color that adapts to system traits (light/dark mode).
/// It contains two color values: one for light mode and one for dark mode.
public struct SnappThemingDynamicColor: Codable {
    private let light: String
    private let dark: String

    #if canImport(UIKit)
        /// Returns a `UIColor` for the current user interface style (light or dark mode).
        /// - Parameter colorFormat: The color format to use (e.g., ARGB, RGBA).
        /// - Returns: A `UIColor` object that adapts based on the system's traits.
        public func uiColor(using colorFormat: SnappThemingColorFormat)
            -> UIColor
        {
            #if !os(watchOS)
                return UIColor { (traits) -> UIColor in
                    // Return one of two colors depending on light or dark mode
                    return traits.userInterfaceStyle == .dark
                        ? UIColor(hex: dark, format: colorFormat)
                        : UIColor(hex: light, format: colorFormat)
                }
            #else
                return UIColor(hex: dark, format: colorFormat)
            #endif
        }
    #elseif canImport(AppKit)
        /// Returns an `NSColor` that dynamically adapts to the system's appearance (light or dark mode).
        ///
        /// - Parameter colorFormat: The format of the color (e.g., RGB, RGBA).
        /// - Returns: A dynamically resolving `NSColor` that changes based on the system's appearance.
        public func nsColor(using colorFormat: SnappThemingColorFormat) -> NSColor {
            NSColor(
                name: nil,
                dynamicProvider: { appearance in
                    switch appearance.name {
                    case .aqua,
                        .vibrantLight,
                        .accessibilityHighContrastAqua,
                        .accessibilityHighContrastVibrantLight:
                        // Returns the light mode variant of the color
                        return NSColor(Color(hex: light, format: colorFormat))

                    case .darkAqua,
                        .vibrantDark,
                        .accessibilityHighContrastDarkAqua,
                        .accessibilityHighContrastVibrantDark:
                        // Returns the dark mode variant of the color
                        return NSColor(Color(hex: dark, format: colorFormat))

                    default:
                        // Returns the dark mode variant of the color
                        assertionFailure("Unknown appearance: \(appearance.name)")
                        return NSColor(Color(hex: light, format: colorFormat))
                    }
                }
            )
        }
    #endif

    /// Returns a `Color` for the current user interface style (light or dark mode).
    /// - Parameter colorFormat: The color format to use (e.g., ARGB, RGBA).
    /// - Returns: A `Color` object that adapts based on the system's traits.
    public func color(using colorFormat: SnappThemingColorFormat) -> Color {
        let lightColor = Color(hex: light, format: colorFormat)
        let darkColor = Color(hex: dark, format: colorFormat)
        // Use dynamic `Color` for light/dark mode support
        return Color(light: lightColor, dark: darkColor)
    }
}
