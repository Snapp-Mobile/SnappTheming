//
//  SAThemingToggleStyleDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public typealias SAThemingToggleStyleDeclarations = SAThemingDeclarations<SAThemingToggleStyleRepresentation, SAThemingToggleStyleConfiguration>

extension SAThemingToggleStyleDeclarations where DeclaredValue == SAThemingToggleStyleRepresentation, Configuration == SAThemingToggleStyleConfiguration {
    public init(
        cache: [String: SAThemingToken<DeclaredValue>]?,
        configuration: SAThemingParserConfiguration,
        colors: SAThemingColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .toggleStyle,
            configuration: SAThemingToggleStyleConfiguration(
                fallbackTintColor: configuration.fallbackColor,
                fallbackDisabledTintColor: configuration.fallbackColor,
                colors: colors,
                colorFormat: configuration.colorFormat
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SAThemingToggleStyleResolver {
        guard
            let representation: SAThemingToggleStyleRepresentation = self[dynamicMember: keyPath],
            let resolvedTintColor = configuration.colors
                .resolver.resolve(representation.tintColor)?
                .color(using: configuration.colorFormat),
            let resolvedDisabledTintColor = configuration.colors
                .resolver.resolve(representation.disabledTintColor)?
                .color(using: configuration.colorFormat)
        else { return .empty() }

        return SAThemingToggleStyleResolver(
            tintColor: resolvedTintColor,
            disabledTintColor: resolvedDisabledTintColor
        )
    }
}
