//
//  SAThemingButtonStyleDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public typealias SAThemingButtonStyleDeclarations = SAThemingDeclarations<SAThemingButtonStyleRepresentation, SAThemingButtonStyleConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingButtonStyleRepresentation, Configuration == SAThemingButtonStyleConfiguration {
    public init(
        cache: [String: SAThemingToken<DeclaredValue>]?,
        configuration: SAThemingParserConfiguration,
        metrics: SAThemingMetricDeclarations,
        fonts: SAThemingFontDeclarations,
        colors: SAThemingColorDeclarations,
        shapes: SAThemingButtonStyleShapeDeclarations,
        typographies: SAThemingTypographyDeclarations,
        interactiveColors: SAThemingInteractiveColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .buttonDeclarations,
            configuration: SAThemingButtonStyleConfiguration(
                fallbackSurfaceColor: configuration.fallbackButtonStyle.surfaceColor,
                fallbackTextColor: configuration.fallbackButtonStyle.textColor,
                fallbackBorderColor: configuration.fallbackButtonStyle.borderColor,
                fallbackBorderWidth: configuration.fallbackButtonStyle.borderWidth,
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallBackTypography: configuration.fallbackButtonStyle.typography,
                metrics: metrics,
                fonts: fonts,
                colors: colors,
                shapes: shapes,
                typographies: typographies,
                interactiveColors: interactiveColors,
                colorFormat: configuration.colorFormat,
                themeConfiguration: configuration
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SAThemingButtonStyleResolver {
        guard
            let representation: SAThemingButtonStyleRepresentation = self[dynamicMember: keyPath],
            let borderWidth = configuration.metrics.resolver.resolve(representation.borderWidth),
            let surfaceColor = configuration.interactiveColors.resolver
                .resolve(representation.surfaceColor)?.resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let textColor = configuration
                .interactiveColors.resolver.resolve(representation.textColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let borderColor = configuration.interactiveColors.resolver.resolve(representation.borderColor)?.resolver(colorFormat: configuration.colorFormat, colors: configuration.colors).interactiveColor,
            let shape = configuration.shapes.resolver.resolve(representation.shape)?.resolver(metric: configuration.metrics).shape,
            let typography = configuration.typographies.resolver.resolve(representation.typography),
            let font = configuration.fonts.resolver.resolve(typography.font),
            let fontSize = configuration.metrics.resolver.resolve(typography.fontSize)
        else {
            return SAThemingButtonStyleResolver(
                surfaceColor: configuration.fallbackSurfaceColor,
                textColor: configuration.fallbackTextColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape,
                typography: configuration.fallBackTypography
            )
        }
        return SAThemingButtonStyleResolver(
            surfaceColor: surfaceColor,
            textColor: textColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            shape: shape,
            typography: .init(font.resolver, fontSize: fontSize.cgFloat)
        )
    }
}
