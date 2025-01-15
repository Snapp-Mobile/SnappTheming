//
//  SnappThemingInteractiveColorDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// Handles a set of colors representing interaction states, such as `normal`, `pressed`, and `disabled`. Useful for managing button states, toggle switches, and other interactive elements.
public typealias SnappThemingInteractiveColorDeclarations = SnappThemingDeclarations<SnappThemingInteractiveColorInformation, SnappThemingInteractiveColorConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingInteractiveColorInformation,
                             Configuration == SnappThemingInteractiveColorConfiguration
{
    /// Initializes the `SnappThemingDeclarations` with a cache of tokens and a configuration.
    ///
    /// - Parameters:
    ///   - cache: A dictionary of cached tokens, where the key is a string and the value is a `SnappThemingToken` containing a `SnappThemingInteractiveColorInformation`.
    ///   - configuration: The configuration used to set up the theming declarations, with a default configuration provided if not specified.
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
