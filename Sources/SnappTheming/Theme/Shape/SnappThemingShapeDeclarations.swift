//
//  SnappThemingShapeDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import OSLog
import SwiftUI

/// Manages button shape tokens, defining the appearance of button outlines, such as circular, rounded rectangle, or custom shapes.
public typealias SnappThemingShapeDeclarations = SnappThemingDeclarations<
    SnappThemingShapeRepresentation,
    SnappThemingShapeConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingShapeRepresentation,
    Configuration == SnappThemingShapeConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        metrics: SnappThemingMetricDeclarations,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(
            cache: cache,
            rootKey: .shapes,
            configuration: Configuration(
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallbackCornerRadius: configuration.fallbackCornerRadius,
                fallbackRoundedCornerStyle: configuration.fallbackRoundedCornerStyle,
                fallbackCornerRadii: configuration.fallbackCornerRadii,
                themeConfiguration: configuration,
                metrics: metrics
            )
        )
    }

    @ShapeBuilder
    public subscript(dynamicMember keyPath: String) -> some Shape {
        if let shapeRepresentation: DeclaredValue = self[dynamicMember: keyPath] {
            shapeRepresentation.resolver(configuration: configuration)
        } else {
            // can't log here because ShapeBuilder is @resultBuilder
            Rectangle()
        }
    }
}
