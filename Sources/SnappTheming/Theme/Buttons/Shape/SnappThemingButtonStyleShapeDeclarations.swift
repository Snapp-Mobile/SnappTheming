//
//  SnappThemingButtonStyleShapeDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

public typealias SnappThemingButtonStyleShapeDeclarations = SnappThemingDeclarations<SnappThemingButtonStyleShapeRepresentation, SnappThemingButtonStyleShapeConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingButtonStyleShapeRepresentation,
                             Configuration == SnappThemingButtonStyleShapeConfiguration
{
    public init(cache: [String: SnappThemingToken<DeclaredValue>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .shapes,
            configuration: .init(
                fallbackShape: configuration.fallbackButtonStyle.shape,
                themeConfiguration: configuration
            )
        )
    }
}
