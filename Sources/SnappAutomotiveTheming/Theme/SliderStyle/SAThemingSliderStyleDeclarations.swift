//
//  SAThemingSliderStyleDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public typealias SAThemingSliderStyleDeclarations = SAThemingDeclarations<SAThemingSliderStyleRepresentation, SAThemingSliderStyleConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingSliderStyleRepresentation, Configuration == SAThemingSliderStyleConfiguration {
    public init(
        cache: [String: SAThemingToken<DeclaredValue>]?,
        configuration: SAThemingParserConfiguration,
        metrics: SAThemingMetricDeclarations,
        colors: SAThemingColorDeclarations,
        fonts: SAThemingFontDeclarations,
        typographies: SAThemingTypographyDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .sliderStyle,
            configuration: SAThemingSliderStyleConfiguration(
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

    public subscript(dynamicMember keyPath: String) -> SAThemingSliderStyleResolver {
        guard
            let representation: SAThemingSliderStyleRepresentation = self[dynamicMember: keyPath],
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
            return SAThemingSliderStyleResolver(
                minimumTrackTintColor: configuration.fallbackMinimumTrackTintColor,
                minimumTrackTintColorSecondary: configuration.fallbackMinimumTrackTintColor,
                maximumTrackTintColor: configuration.fallbackMaximumTrackTintColor,
                headerTypography: .init(.system, fontSize: configuration.fallbackFontSize),
                tickMarkTypography: .init(.system, fontSize: configuration.fallbackFontSize),
                tickMarkColor: configuration.fallbackTickMarkColor
            )
        }
        return SAThemingSliderStyleResolver(
            minimumTrackTintColor: resolvedMinimumTrackTintColor,
            minimumTrackTintColorSecondary: resolvedMinimumTrackTintColorSecondary,
            maximumTrackTintColor: resolvedMaximumTrackTintColor,
            headerTypography: SAThemingTypographyResolver(resolvedHeaderFont.resolver, fontSize: resolvedHeaderFontSize),
            tickMarkTypography: SAThemingTypographyResolver(resolvedTickMarkFont.resolver, fontSize: resolvedTickMarkFontSize),
            tickMarkColor: resolvedTickMarkColor
        )
    }
}
