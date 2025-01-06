//
//  SAThemingShapeStyleDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SwiftUI

public typealias SAThemingShapeStyleDeclarations = SAThemingDeclarations<SAThemingShapeStyleRepresentation, SAThemingShapeStyleConfiguration>

public struct SAThemingShapeStyleConfiguration {
    public let fallbackShapeStyle: Color
}

extension SAThemingDeclarations where DeclaredValue == SAThemingShapeStyleRepresentation, Configuration == SAThemingShapeStyleConfiguration {
    public init(cache: [String: SAThemingToken<SAThemingShapeStyleRepresentation>]?, configuration: SAThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .shapeStyle,
            configuration: .init(
                fallbackShapeStyle: configuration.fallbackColor
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> some ShapeStyle {
        guard let representation: SAThemingShapeStyleRepresentation = self[dynamicMember: keyPath] else {
            return AnyShapeStyle(configuration.fallbackShapeStyle)
        }

        return AnyShapeStyle(representation.configuration.shapeStyle)
    }
}
