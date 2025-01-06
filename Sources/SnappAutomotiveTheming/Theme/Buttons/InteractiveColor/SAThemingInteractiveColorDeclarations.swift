//
//  SAThemingInteractiveColorDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public typealias SAThemingInteractiveColorDeclarations = SAThemingDeclarations<SAThemingInteractiveColorInformation, SAThemingInteractiveColorConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingInteractiveColorInformation,
                             Configuration == SAThemingInteractiveColorConfiguration
{
    public init(cache: [String: SAThemingToken<DeclaredValue>]?, configuration: SAThemingParserConfiguration = .default) {
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
