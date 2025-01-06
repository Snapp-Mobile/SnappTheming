//
//  SAThemingButtonStyleShapeDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

public typealias SAThemingButtonStyleShapeDeclarations = SAThemingDeclarations<SAThemingButtonStyleShapeRepresentation, SAThemingButtonStyleShapeConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingButtonStyleShapeRepresentation,
                             Configuration == SAThemingButtonStyleShapeConfiguration
{
    public init(cache: [String: SAThemingToken<DeclaredValue>]?, configuration: SAThemingParserConfiguration = .default) {
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
