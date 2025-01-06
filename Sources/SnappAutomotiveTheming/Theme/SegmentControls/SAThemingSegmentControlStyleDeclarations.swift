//
//  File.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public typealias SAThemingSegmentControlStyleDeclarations = SAThemingDeclarations<SAThemingSegmentControlStyleRepresentation, SAThemingSegmentControlStyleConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingSegmentControlStyleRepresentation, Configuration == SAThemingSegmentControlStyleConfiguration {
    public init(
        cache: [String: SAThemingToken<DeclaredValue>]?,
        configuration: SAThemingParserConfiguration,
        metrics: SAThemingMetricDeclarations,
        colors: SAThemingColorDeclarations,
        shapes: SAThemingButtonStyleShapeDeclarations,
        buttonStyles: SAThemingButtonStyleDeclarations,
        fonts: SAThemingFontDeclarations,
        typographies: SAThemingTypographyDeclarations,
        interactiveColors: SAThemingInteractiveColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .segmentControlStyle,
            configuration: SAThemingSegmentControlStyleConfiguration(
                fallbackSurfaceColor: configuration.fallbackButtonStyle.surfaceColor,
                fallbackBorderColor: configuration.fallbackButtonStyle.borderColor,
                fallbackBorderWidth: configuration.fallbackButtonStyle.borderWidth,
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallbackSelectedSegment: configuration.fallbackButtonStyle,
                fallbackNormalSegment: configuration.fallbackButtonStyle,
                metrics: metrics,
                fonts: fonts,
                colors: colors,
                shapes: shapes,
                interactiveColors: interactiveColors,
                typographies: typographies,
                buttonStyles: buttonStyles,
                colorFormat: configuration.colorFormat,
                themeConfiguration: configuration
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SAThemingSegmentControlStyleResolver {
        guard
            let representation: SAThemingSegmentControlStyleRepresentation = self[dynamicMember: keyPath],
            let borderWidth = configuration.metrics.resolver
                .resolve(representation.borderWidth),
            let padding = configuration.metrics.resolver
                .resolve(representation.padding),
            let surfaceColor = configuration.interactiveColors.resolver
                .resolve(representation.surfaceColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors)
                .interactiveColor,
            let borderColor = configuration.interactiveColors.resolver
                .resolve(representation.borderColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors)
                .interactiveColor,
            let shape = configuration.shapes.resolver.resolve(representation.shape)?.resolver(metric: configuration.metrics).shape,
            let selectedButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.selectedButtonStyle)?
                .resolver(using: configuration),
            let normalButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.normalButtonStyle)?
                .resolver(using: configuration)
        else {
            return SAThemingSegmentControlStyleResolver(
                selectedButtonStyle: configuration.fallbackSelectedSegment,
                normalButtonStyle: configuration.fallbackNormalSegment,
                surfaceColor: configuration.fallbackSurfaceColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                innerPadding: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape
            )
        }

        return SAThemingSegmentControlStyleResolver(
            selectedButtonStyle: selectedButtonStyle,
            normalButtonStyle: normalButtonStyle,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            innerPadding: padding,
            shape: shape
        )
    }
}
