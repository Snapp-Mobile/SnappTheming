//
//  SnappThemingSegmentControlStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SnappThemingSegmentControlStyleConfiguration {
    public let fallbackSurfaceColor: SnappThemingInteractiveColor
    public let fallbackBorderColor: SnappThemingInteractiveColor
    public let fallbackBorderWidth: Double
    public let fallbackShape: SnappThemingButtonStyleType
    public let fallbackSelectedSegment: SnappThemingButtonStyleResolver
    public let fallbackNormalSegment: SnappThemingButtonStyleResolver

    let metrics: SnappThemingMetricDeclarations
    let fonts: SnappThemingFontDeclarations
    let colors: SnappThemingColorDeclarations
    let shapes: SnappThemingButtonStyleShapeDeclarations
    let interactiveColors: SnappThemingInteractiveColorDeclarations
    let typographies: SnappThemingTypographyDeclarations
    let buttonStyles: SnappThemingButtonStyleDeclarations
    public let colorFormat: SnappThemingColorFormat
    let themeConfiguration: SnappThemingParserConfiguration
}
