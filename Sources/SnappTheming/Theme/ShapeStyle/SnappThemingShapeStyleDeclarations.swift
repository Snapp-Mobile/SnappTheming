//
//  SnappThemingShapeStyleDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SwiftUI

/// Manages shape style tokens, including support for gradients such as linear, radial, and angular, enabling the creation of dynamic and visually appealing shape backgrounds.
public typealias SnappThemingShapeStyleDeclarations = SnappThemingDeclarations<SnappThemingShapeStyleRepresentation, SnappThemingShapeStyleConfiguration>

/// Configuration for resolving shape styles in the theming system.
public struct SnappThemingShapeStyleConfiguration {
    /// The fallback shape style to use when a specific shape style cannot be resolved.
    public let fallbackShapeStyle: Color
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingShapeStyleRepresentation, Configuration == SnappThemingShapeStyleConfiguration {
    /// Initializes the declarations for resolving shape styles in the theming system.
    ///
    /// - Parameters:
    ///   - cache: An optional cache of theming tokens for shape styles.
    ///   - configuration: The parser configuration, defaulting to `.default`.
    public init(cache: [String: SnappThemingToken<SnappThemingShapeStyleRepresentation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .shapeStyle,
            configuration: .init(
                fallbackShapeStyle: configuration.fallbackColor
            )
        )
    }

    /// Accesses the shape style corresponding to the given key path.
    ///
    /// - Parameter keyPath: The dynamic member key path representing the shape style.
    /// - Returns: A resolved shape style, or the fallback shape style wrapped in `AnyShapeStyle` if not found.
    public subscript(dynamicMember keyPath: String) -> some ShapeStyle {
        guard let representation: SnappThemingShapeStyleRepresentation = self[dynamicMember: keyPath] else {
            return AnyShapeStyle(configuration.fallbackShapeStyle)
        }

        return AnyShapeStyle(representation.configuration.shapeStyle)
    }
}
