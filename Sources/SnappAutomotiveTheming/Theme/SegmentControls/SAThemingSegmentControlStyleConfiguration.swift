//
//  SAThemingSegmentControlStyleConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SAThemingSegmentControlStyleConfiguration {
    public let fallbackSurfaceColor: SAThemingInteractiveColor
    public let fallbackBorderColor: SAThemingInteractiveColor
    public let fallbackBorderWidth: Double
    public let fallbackShape: SAThemingButtonStyleShape
    public let fallbackSelectedSegment: SAThemingButtonStyleResolver
    public let fallbackNormalSegment: SAThemingButtonStyleResolver

    let metrics: SAThemingMetricDeclarations
    let fonts: SAThemingFontDeclarations
    let colors: SAThemingColorDeclarations
    let shapes: SAThemingButtonStyleShapeDeclarations
    let interactiveColors: SAThemingInteractiveColorDeclarations
    let typographies: SAThemingTypographyDeclarations
    let buttonStyles: SAThemingButtonStyleDeclarations
    public let colorFormat: SAThemingColorFormat
    let themeConfiguration: SAThemingParserConfiguration
}
