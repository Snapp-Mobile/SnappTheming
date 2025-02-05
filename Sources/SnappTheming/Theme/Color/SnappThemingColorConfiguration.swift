//
//  SnappThemingColorConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    import UIKit
#endif

/// A structure representing the configuration for theming colors in the Snapp application.
///
/// - `fallbackColor`: The default color to use if no matching color is found in the configuration.
/// - `colorFormat`: Specifies the format in which colors are represented (e.g., hex, dynamic, etc.).
///
/// This structure is designed to help configure colors that will be used across the app, with a fallback in case of missing or incorrect values.
public struct SnappThemingColorConfiguration {
    /// The default color to fall back to when a color is not available in the theme.
    public let fallbackColor: Color
    #if canImport(UIKit)
        /// A `UIColor` representation of the `fallbackColor`.
        public var fallbackUIColor: UIColor { UIColor(fallbackColor) }
    #elseif canImport(AppKit)
        /// A `UIColor` representation of the `fallbackColor`.
        public var fallbackNSColor: NSColor { .clear }
    #endif

    /// The format of the color (ARGB or RGBA).
    public let colorFormat: SnappThemingColorFormat
}
