//
//  SnappThemingButtonStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SnappThemingButtonStyleConfiguration {
    public let fallbackSurfaceColor: SnappThemingInteractiveColor
    public let fallbackTextColor: SnappThemingInteractiveColor
    public let fallbackBorderColor: SnappThemingInteractiveColor
    public let fallbackBorderWidth: Double
    public let fallbackShape: SnappThemingButtonStyleType
    public let fallBackTypography: SnappThemingTypographyResolver

    let metrics: SnappThemingMetricDeclarations
    let fonts: SnappThemingFontDeclarations
    let colors: SnappThemingColorDeclarations
    let shapes: SnappThemingButtonStyleShapeDeclarations
    let typographies: SnappThemingTypographyDeclarations
    let interactiveColors: SnappThemingInteractiveColorDeclarations
    public let colorFormat: SnappThemingColorFormat
    let themeConfiguration: SnappThemingParserConfiguration
}
