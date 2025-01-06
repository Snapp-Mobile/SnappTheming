//
//  SAThemingButtonStyleConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingButtonStyleConfiguration {
    public let fallbackSurfaceColor: SAThemingInteractiveColor
    public let fallbackTextColor: SAThemingInteractiveColor
    public let fallbackBorderColor: SAThemingInteractiveColor
    public let fallbackBorderWidth: Double
    public let fallbackShape: SAThemingButtonStyleType
    public let fallBackTypography: SAThemingTypographyResolver

    let metrics: SAThemingMetricDeclarations
    let fonts: SAThemingFontDeclarations
    let colors: SAThemingColorDeclarations
    let shapes: SAThemingButtonStyleShapeDeclarations
    let typographies: SAThemingTypographyDeclarations
    let interactiveColors: SAThemingInteractiveColorDeclarations
    public let colorFormat: SAThemingColorFormat
    let themeConfiguration: SAThemingParserConfiguration
}
