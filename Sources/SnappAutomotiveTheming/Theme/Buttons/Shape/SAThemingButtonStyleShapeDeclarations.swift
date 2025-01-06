//
//  SAThemingButtonStyleShapeDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

public typealias SAThemingButtonStyleShapeDeclarations = SAThemingDeclarations<SAThemingButtonStyleShapeInformation, SAThemingButtonStyleShapeConfiguration>

extension SAThemingDeclarations where DeclaredValue == SAThemingButtonStyleShapeInformation,
                             Configuration == SAThemingButtonStyleShapeConfiguration
{
    public init(cache: [String: SAThemingToken<DeclaredValue>]?, configuration: SAThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .shapes,
            configuration: .init(
                fallbackWidth: configuration.fallbackButtonStyle.shape.width ?? 0.0,
                fallbackHeight: configuration.fallbackButtonStyle.shape.height ?? 0.0,
                fallbackCornerRadius: configuration.fallbackButtonStyle.shape.cornerRadius,
                themeConfiguration: configuration
            )
        )
    }
}
