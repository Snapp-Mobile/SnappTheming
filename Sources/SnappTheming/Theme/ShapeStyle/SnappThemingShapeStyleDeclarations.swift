//
//  SnappThemingShapeStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SwiftUI

/// Manages shape style tokens, including support for gradients such as linear, radial, and angular, enabling the creation of dynamic and visually appealing shape backgrounds.
public typealias SnappThemingShapeStyleDeclarations = SnappThemingDeclarations<SnappThemingShapeStyleRepresentation, SnappThemingShapeStyleConfiguration>

public struct SnappThemingShapeStyleConfiguration {
    public let fallbackShapeStyle: Color
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingShapeStyleRepresentation, Configuration == SnappThemingShapeStyleConfiguration {
    public init(cache: [String: SnappThemingToken<SnappThemingShapeStyleRepresentation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .shapeStyle,
            configuration: .init(
                fallbackShapeStyle: configuration.fallbackColor
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> some ShapeStyle {
        guard let representation: SnappThemingShapeStyleRepresentation = self[dynamicMember: keyPath] else {
            return AnyShapeStyle(configuration.fallbackShapeStyle)
        }

        return AnyShapeStyle(representation.configuration.shapeStyle)
    }
}
