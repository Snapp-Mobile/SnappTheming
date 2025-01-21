//
//  SnappThemingToggleStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// Manages toggle style tokens, allowing control over the appearance of toggles, such as colors for enabled/disabled states.
public typealias SnappThemingToggleStyleDeclarations = SnappThemingDeclarations<
    SnappThemingToggleStyleRepresentation,
    SnappThemingToggleStyleConfiguration
>

extension SnappThemingToggleStyleDeclarations
where
    DeclaredValue == SnappThemingToggleStyleRepresentation,
    Configuration == SnappThemingToggleStyleConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        colors: SnappThemingColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .toggleStyle,
            configuration: SnappThemingToggleStyleConfiguration(
                fallbackTintColor: configuration.fallbackColor,
                fallbackDisabledTintColor: configuration.fallbackColor,
                colors: colors,
                colorFormat: configuration.colorFormat
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingToggleStyleResolver {
        guard
            let representation: SnappThemingToggleStyleRepresentation = self[dynamicMember: keyPath],
            let resolvedTintColor = configuration.colors
                .resolver.resolve(representation.tintColor)?
                .color(using: configuration.colorFormat),
            let resolvedDisabledTintColor = configuration.colors
                .resolver.resolve(representation.disabledTintColor)?
                .color(using: configuration.colorFormat)
        else { return .empty() }

        return SnappThemingToggleStyleResolver(
            tintColor: resolvedTintColor,
            disabledTintColor: resolvedDisabledTintColor
        )
    }
}
