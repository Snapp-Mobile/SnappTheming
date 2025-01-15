//
//  SnappThemingShapeDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// Manages button shape tokens, defining the appearance of button outlines, such as circular, rounded rectangle, or custom shapes.
public typealias SnappThemingShapeDeclarations = SnappThemingDeclarations<SnappThemingShapeRepresentation, SnappThemingShapeConfiguration>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingShapeRepresentation,
                             Configuration == SnappThemingShapeConfiguration
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
