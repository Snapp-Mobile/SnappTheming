//
//  SnappThemingInteractiveColorDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

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
