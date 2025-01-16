//
//  SnappThemingSliderStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// Handles slider style tokens, managing properties like track colors, tick mark styles for sliders used in the UI.
public typealias SnappThemingSliderStyleDeclarations = SnappThemingDeclarations<SnappThemingSliderStyleRepresentation, SnappThemingSliderStyleConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingSliderStyleRepresentation, Configuration == SnappThemingSliderStyleConfiguration {
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        metrics: SnappThemingMetricDeclarations,
        colors: SnappThemingColorDeclarations,
        fonts: SnappThemingFontDeclarations,
        typographies: SnappThemingTypographyDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .sliderStyle,
            configuration: SnappThemingSliderStyleConfiguration(
                fallbackMinimumTrackTintColor: configuration.fallbackColor,
                fallbackMaximumTrackTintColor: configuration.fallbackColor,
                fallbackFontSize: configuration.fallbackMetric,
                fallbackTickMarkColor: configuration.fallbackColor,
                typographies: typographies,
                colors: colors,
                fonts: fonts,
                metrics: metrics,
                colorFormat: configuration.colorFormat
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingSliderStyleResolver {
        guard
            let representation: SnappThemingSliderStyleRepresentation = self[dynamicMember: keyPath],
            let resolvedMinimumTrackTintColor = configuration.colors
                .resolver.resolve(representation.minimumTrackTintColor)?
                .color(using: configuration.colorFormat),
            let resolvedMinimumTrackTintColorSecondary = configuration.colors
                .resolver.resolve(representation.minimumTrackTintColorSecondary)?
                .color(using: configuration.colorFormat),
            let resolvedMaximumTrackTintColor = configuration.colors
                .resolver.resolve(representation.maximumTrackTintColor)?
                .color(using: configuration.colorFormat),
            let resolvedTickMarkColor = configuration.colors
                .resolver.resolve(representation.tickMarkColor)?
                .color(using: configuration.colorFormat),
            let resolvedHeaderTypography = configuration.typographies
                .resolver.resolve(representation.headerTypography),
            let resolvedHeaderFont = configuration.fonts
                .resolver.resolve(resolvedHeaderTypography.font),
            let resolvedHeaderFontSize = configuration.metrics
                .resolver.resolve(resolvedHeaderTypography.fontSize),
            let resolvedTickMarkTypography = configuration.typographies
                .resolver.resolve(representation.tickMarkTypography),
            let resolvedTickMarkFont = configuration.fonts
                .resolver.resolve(resolvedTickMarkTypography.font),
            let resolvedTickMarkFontSize = configuration.metrics
                .resolver.resolve(resolvedTickMarkTypography.fontSize)
        else {
            return SnappThemingSliderStyleResolver(
                minimumTrackTintColor: configuration.fallbackMinimumTrackTintColor,
                minimumTrackTintColorSecondary: configuration.fallbackMinimumTrackTintColor,
                maximumTrackTintColor: configuration.fallbackMaximumTrackTintColor,
                headerTypography: .init(.system, fontSize: configuration.fallbackFontSize),
                tickMarkTypography: .init(.system, fontSize: configuration.fallbackFontSize),
                tickMarkColor: configuration.fallbackTickMarkColor
            )
        }
        return SnappThemingSliderStyleResolver(
            minimumTrackTintColor: resolvedMinimumTrackTintColor,
            minimumTrackTintColorSecondary: resolvedMinimumTrackTintColorSecondary,
            maximumTrackTintColor: resolvedMaximumTrackTintColor,
            headerTypography: SnappThemingTypographyResolver(resolvedHeaderFont.resolver, fontSize: resolvedHeaderFontSize),
            tickMarkTypography: SnappThemingTypographyResolver(resolvedTickMarkFont.resolver, fontSize: resolvedTickMarkFontSize),
            tickMarkColor: resolvedTickMarkColor
        )
    }
}
