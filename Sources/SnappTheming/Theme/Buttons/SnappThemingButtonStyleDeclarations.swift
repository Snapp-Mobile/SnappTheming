//
//  SnappThemingButtonStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

public typealias SnappThemingButtonStyleDeclarations = SnappThemingDeclarations<
    SnappThemingButtonStyleRepresentation,
    SnappThemingButtonStyleConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingButtonStyleRepresentation,
    Configuration == SnappThemingButtonStyleConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        metrics: SnappThemingMetricDeclarations,
        fonts: SnappThemingFontDeclarations,
        colors: SnappThemingColorDeclarations,
        shapes: SnappThemingShapeDeclarations,
        typographies: SnappThemingTypographyDeclarations,
        interactiveColors: SnappThemingInteractiveColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .buttonStyles,
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

    public subscript(dynamicMember keyPath: String) -> SnappThemingButtonStyleResolver {
        guard
            let representation: SnappThemingButtonStyleRepresentation = self[dynamicMember: keyPath],
            let borderWidth = configuration.metrics.resolver.resolve(representation.borderWidth),
            let surfaceColor = configuration.interactiveColors.resolver
                .resolve(representation.surfaceColor)?.resolver(
                    colorFormat: configuration.colorFormat, colors: configuration.colors
                ).interactiveColor,
            let textColor = configuration
                .interactiveColors.resolver.resolve(representation.textColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let borderColor = configuration.interactiveColors.resolver.resolve(representation.borderColor)?.resolver(
                colorFormat: configuration.colorFormat, colors: configuration.colors
            ).interactiveColor,
            let shape = configuration.shapes.resolver.resolve(representation.shape),
            let typography = configuration.typographies.resolver.resolve(representation.typography),
            let font = configuration.fonts.resolver.resolve(typography.font),
            let fontSize = configuration.metrics.resolver.resolve(typography.fontSize)
        else {
            return SnappThemingButtonStyleResolver(
                surfaceColor: configuration.fallbackSurfaceColor,
                textColor: configuration.fallbackTextColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape,
                typography: configuration.fallbackTypography
            )
        }
        return SnappThemingButtonStyleResolver(
            surfaceColor: surfaceColor,
            textColor: textColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            shape: configuration.shapes.configuration.resolve(shape),
            typography: .init(font.resolver, fontSize: fontSize.cgFloat)
        )
    }

    @MainActor
    public subscript(dynamicMember keyPath: String) -> some ButtonStyle {
        let styleResolver: SnappThemingButtonStyleResolver = self[dynamicMember: keyPath]
        return SnappThemingButtonStyle(
            surfaceColor: styleResolver.surfaceColor,
            textColor: styleResolver.textColor,
            borderColor: styleResolver.borderColor,
            borderWidth: styleResolver.borderWidth,
            shape: styleResolver.shape,
            font: styleResolver.typography.font)
    }
}
