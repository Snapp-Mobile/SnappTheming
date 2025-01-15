//
//  SnappThemingInteractiveColorConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 30.11.2024.
//

import SwiftUI

/// A struct that holds the configuration for interactive colors, including a fallback color, color format, and theme configuration.
/// This is used for theming interactive elements such as buttons, with specific colors for different states (normal, pressed, disabled).
public struct SnappThemingInteractiveColorConfiguration {
    /// The fallback color to use if no specific interactive color is defined.
    public let fallbackColor: SnappThemingInteractiveColor

    /// The format used to represent the color, such as ARGB or RGBA.
    public let colorFormat: SnappThemingColorFormat

    /// The theme configuration used to parse and handle interactive colors.
    let themeConfiguration: SnappThemingParserConfiguration
}
