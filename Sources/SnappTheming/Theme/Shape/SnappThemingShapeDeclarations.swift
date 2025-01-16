//
//  SnappThemingShapeDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

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

    @ShapeBuilder
    public subscript(dynamicMember keyPath: String) -> some Shape {
        if let representation = cache[keyPath]?.value {
            representation.resolver().shapeType.value
        } else {
            configuration.fallbackShape.styleShape
        }
    }

}
