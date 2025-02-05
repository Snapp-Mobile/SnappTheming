//
//  SnappThemingSegmentControlStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public typealias SnappThemingSegmentControlStyleDeclarations = SnappThemingDeclarations<
    SnappThemingSegmentControlStyleRepresentation,
    SnappThemingSegmentControlStyleConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingSegmentControlStyleRepresentation,
    Configuration == SnappThemingSegmentControlStyleConfiguration
{
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
            configuration: Configuration(
                fallbackSurfaceColor: configuration.fallbackButtonStyle.surfaceColor,
                fallbackBorderColor: configuration.fallbackButtonStyle.borderColor,
                fallbackBorderWidth: configuration.fallbackButtonStyle.borderWidth,
                fallbackInnerPadding: configuration.fallbackButtonStyle.borderWidth,
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallbackSelectedSegmentButtonStyle: configuration.fallbackButtonStyle,
                fallbackNormalSegmentButtonStyle: configuration.fallbackButtonStyle,
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
            let representation: DeclaredValue = self[dynamicMember: keyPath],
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
            let shapeRepresentation = configuration.shapes.resolver
                .resolve(representation.shape),
            let selectedButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.selectedButtonStyle)?
                .resolver(using: configuration),
            let normalButtonStyle = configuration.buttonStyles.resolver
                .resolve(representation.normalButtonStyle)?
                .resolver(using: configuration)
        else {
            return SnappThemingSegmentControlStyleResolver(
                selectedButtonStyle: configuration.fallbackSelectedSegmentButtonStyle,
                normalButtonStyle: configuration.fallbackNormalSegmentButtonStyle,
                surfaceColor: configuration.fallbackSurfaceColor,
                borderColor: configuration.fallbackBorderColor,
                borderWidth: configuration.fallbackBorderWidth,
                innerPadding: configuration.fallbackBorderWidth,
                shape: configuration.fallbackShape
            )
        }

        let shapeType = configuration.shapes.configuration.resolve(shapeRepresentation)
        return SnappThemingSegmentControlStyleResolver(
            selectedButtonStyle: selectedButtonStyle,
            normalButtonStyle: normalButtonStyle,
            surfaceColor: surfaceColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            innerPadding: padding,
            shape: shapeType
        )
    }
}
