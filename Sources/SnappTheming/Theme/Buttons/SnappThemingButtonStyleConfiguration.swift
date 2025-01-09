//
//  SnappThemingButtonStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// A configuration object for defining button styles within the SnappTheming framework.
///
/// This structure encapsulates fallback properties and theming resources needed for button styling.
/// It supports customization of surface color, text color, border color, typography, and shapes.
public struct SnappThemingButtonStyleConfiguration {
    // MARK: - Public Properties

    /// The default surface color for the button in interactive states.
    public let fallbackSurfaceColor: SnappThemingInteractiveColor

    /// The default text color for the button in interactive states.
    public let fallbackTextColor: SnappThemingInteractiveColor

    /// The default border color for the button in interactive states.
    public let fallbackBorderColor: SnappThemingInteractiveColor

    /// The default border width for the button.
    public let fallbackBorderWidth: Double

    /// The default shape type for the button.
    public let fallbackShape: SnappThemingButtonStyleType

    /// The default typography resolver for button text.
    public let fallbackTypography: SnappThemingTypographyResolver

    /// The color format used throughout the configuration.
    public let colorFormat: SnappThemingColorFormat

    // MARK: - Internal Properties

    let metrics: SnappThemingMetricDeclarations
    let fonts: SnappThemingFontDeclarations
    let colors: SnappThemingColorDeclarations
    let shapes: SnappThemingButtonStyleShapeDeclarations
    let typographies: SnappThemingTypographyDeclarations
    let interactiveColors: SnappThemingInteractiveColorDeclarations
    let themeConfiguration: SnappThemingParserConfiguration
}
