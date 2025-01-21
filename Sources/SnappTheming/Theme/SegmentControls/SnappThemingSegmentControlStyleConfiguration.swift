//
//  SnappThemingSegmentControlStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// A configuration structure for defining the style of a segment control in the SnappTheming system.
public struct SnappThemingSegmentControlStyleConfiguration {
    //  MARK: - Public properties

    /// The fallback color for the surface of the segment control.
    public let fallbackSurfaceColor: SnappThemingInteractiveColor

    /// The fallback color for the border of the segment control.
    public let fallbackBorderColor: SnappThemingInteractiveColor

    /// The fallback width of the segment control's border.
    public let fallbackBorderWidth: Double

    /// The fallback shape style for the segment control.
    public let fallbackShape: SnappThemingShapeType

    /// The fallback style for the selected segment of the control.
    public let fallbackSelectedSegment: SnappThemingButtonStyleResolver

    /// The fallback style for the normal (unselected) segment of the control.
    public let fallbackNormalSegment: SnappThemingButtonStyleResolver

    /// The color format used in the theming system (e.g., Hex, RGBA).
    public let colorFormat: SnappThemingColorFormat

    //  MARK: - Internal properties

    let metrics: SnappThemingMetricDeclarations
    let fonts: SnappThemingFontDeclarations
    let colors: SnappThemingColorDeclarations
    let shapes: SnappThemingShapeDeclarations
    let interactiveColors: SnappThemingInteractiveColorDeclarations
    let typographies: SnappThemingTypographyDeclarations
    let buttonStyles: SnappThemingButtonStyleDeclarations
    let themeConfiguration: SnappThemingParserConfiguration

    internal init(fallbackSurfaceColor: SnappThemingInteractiveColor, fallbackBorderColor: SnappThemingInteractiveColor, fallbackBorderWidth: Double, fallbackShape: SnappThemingShapeType, fallbackSelectedSegment: SnappThemingButtonStyleResolver, fallbackNormalSegment: SnappThemingButtonStyleResolver, metrics: SnappThemingMetricDeclarations, fonts: SnappThemingFontDeclarations, colors: SnappThemingColorDeclarations, shapes: SnappThemingShapeDeclarations, interactiveColors: SnappThemingInteractiveColorDeclarations, typographies: SnappThemingTypographyDeclarations, buttonStyles: SnappThemingButtonStyleDeclarations, colorFormat: SnappThemingColorFormat, themeConfiguration: SnappThemingParserConfiguration) {
        self.fallbackSurfaceColor = fallbackSurfaceColor
        self.fallbackBorderColor = fallbackBorderColor
        self.fallbackBorderWidth = fallbackBorderWidth
        self.fallbackShape = fallbackShape
        self.fallbackSelectedSegment = fallbackSelectedSegment
        self.fallbackNormalSegment = fallbackNormalSegment
        self.metrics = metrics
        self.fonts = fonts
        self.colors = colors
        self.shapes = shapes
        self.interactiveColors = interactiveColors
        self.typographies = typographies
        self.buttonStyles = buttonStyles
        self.colorFormat = colorFormat
        self.themeConfiguration = themeConfiguration
    }
}
