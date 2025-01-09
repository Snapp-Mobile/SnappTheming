//
//  SnappThemingButtonStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

/// Manages button style tokens, including properties like surface and text colors, border widths and color, shape and typography for various button states.
public typealias SnappThemingButtonStyleDeclarations = SnappThemingDeclarations<SnappThemingButtonStyleRepresentation, SnappThemingButtonStyleConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingButtonStyleRepresentation, Configuration == SnappThemingButtonStyleConfiguration {
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        metrics: SnappThemingMetricDeclarations,
        fonts: SnappThemingFontDeclarations,
        colors: SnappThemingColorDeclarations,
        shapes: SnappThemingButtonStyleShapeDeclarations,
        typographies: SnappThemingTypographyDeclarations,
        interactiveColors: SnappThemingInteractiveColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .buttonDeclarations,
            configuration: SnappThemingButtonStyleConfiguration(
                fallbackSurfaceColor: configuration.fallbackButtonStyle.surfaceColor,
                fallbackTextColor: configuration.fallbackButtonStyle.textColor,
                fallbackBorderColor: configuration.fallbackButtonStyle.borderColor,
                fallbackBorderWidth: configuration.fallbackButtonStyle.borderWidth,
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallbackTypography: configuration.fallbackButtonStyle.typography,
                colorFormat: configuration.colorFormat,
                metrics: metrics,
                fonts: fonts,
                colors: colors,
                shapes: shapes,
                typographies: typographies,
                interactiveColors: interactiveColors,
                themeConfiguration: configuration
            )
        )
    }

    @MainActor
    public subscript(dynamicMember keyPath: String) -> some ButtonStyle {
        guard
            let representation: SnappThemingButtonStyleRepresentation = self[dynamicMember: keyPath],
            let borderWidth = configuration.metrics.resolver.resolve(representation.borderWidth),
            let surfaceColor = configuration.interactiveColors.resolver
                .resolve(representation.surfaceColor)?.resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let textColor = configuration
                .interactiveColors.resolver.resolve(representation.textColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let borderColor = configuration.interactiveColors.resolver.resolve(representation.borderColor)?.resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let shape = configuration.shapes.resolver.resolve(representation.shape)?.resolver().buttonStyleType,
            let typography = configuration.typographies.resolver.resolve(representation.typography),
            let font = configuration.fonts.resolver.resolve(typography.font),
            let fontSize = configuration.metrics.resolver.resolve(typography.fontSize)
        else {
            return SnappThemingButtonStyle(
                surfaceColor: configuration.fallbackSurfaceColor,
                textColor: configuration.fallbackTextColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape,
                font: configuration.fallbackTypography.font)
        }
        return SnappThemingButtonStyle(
            surfaceColor: surfaceColor,
            textColor: textColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            shape: shape,
            font: font.resolver.font(size: fontSize))
    }
}
