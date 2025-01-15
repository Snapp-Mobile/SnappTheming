//
//  SnappThemingSegmentControlStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// Manages segment control style tokens, enabling the customization of segment control appearance, including selected/unselected states, borders, shapes, and paddings.
public typealias SnappThemingSegmentControlStyleDeclarations = SnappThemingDeclarations<SnappThemingSegmentControlStyleRepresentation, SnappThemingSegmentControlStyleConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingSegmentControlStyleRepresentation, Configuration == SnappThemingSegmentControlStyleConfiguration {
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        metrics: SnappThemingMetricDeclarations,
        colors: SnappThemingColorDeclarations,
        shapes: SnappThemingShapeDeclarations,
        buttonStyles: SnappThemingButtonStyleDeclarations,
        fonts: SnappThemingFontDeclarations,
        typographies: SnappThemingTypographyDeclarations,
        interactiveColors: SnappThemingInteractiveColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .segmentControlStyle,
            configuration: SnappThemingSegmentControlStyleConfiguration(
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

    public subscript(dynamicMember keyPath: String) -> SnappThemingSegmentControlStyleResolver {
        guard
            let representation: SnappThemingSegmentControlStyleRepresentation = self[dynamicMember: keyPath],
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
            let shape = configuration.shapes.resolver.resolve(representation.shape)?.resolver().shapeType,
            let selectedButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.selectedButtonStyle)?
                .resolver(using: configuration),
            let normalButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.normalButtonStyle)?
                .resolver(using: configuration)
        else {
            return SnappThemingSegmentControlStyleResolver(
                selectedButtonStyle: configuration.fallbackSelectedSegment,
                normalButtonStyle: configuration.fallbackNormalSegment,
                surfaceColor: configuration.fallbackSurfaceColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                innerPadding: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape
            )
        }

        return SnappThemingSegmentControlStyleResolver(
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
