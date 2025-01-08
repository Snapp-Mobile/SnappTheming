//
//  SnappThemingInteractiveColorDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// Handles a set of colors representing interaction states, such as `normal`, `selected`, `pressed`, and `disabled`. Useful for managing button states, toggle switches, and other interactive elements.
public typealias SnappThemingInteractiveColorDeclarations = SnappThemingDeclarations<SnappThemingInteractiveColorInformation, SnappThemingInteractiveColorConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingInteractiveColorInformation,
                             Configuration == SnappThemingInteractiveColorConfiguration
{
    public init(cache: [String: SnappThemingToken<DeclaredValue>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .interactiveColors,
            configuration: .init(
                fallbackColor: configuration.fallbackInteractiveColor,
                colorFormat: configuration.colorFormat,
                themeConfiguration: configuration
            )
        )
    }
}
