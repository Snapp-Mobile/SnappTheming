//
//  SnappThemingGradientDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SwiftUI

/// Manages gradient tokens, including support for linear, radial, and angular gradients, enabling the creation of dynamic and visually appealing shape backgrounds.
public typealias SnappThemingGradientDeclarations = SnappThemingDeclarations<SnappThemingGradientRepresentation, SnappThemingGradientConfiguration>

/// Configuration for resolving gradients in the theming system.
public struct SnappThemingGradientConfiguration {
    /// The fallback color to use when a specific gradient cannot be resolved.
    public let fallbackColor: Color
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingGradientRepresentation, Configuration == SnappThemingGradientConfiguration {
    /// Initializes the declarations for resolving shape styles in the theming system.
    ///
    /// - Parameters:
    ///   - cache: An optional cache of theming tokens for shape styles.
    ///   - configuration: The parser configuration, defaulting to `.default`.
    public init(cache: [String: SnappThemingToken<SnappThemingGradientRepresentation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .gradients,
            configuration: .init(
                fallbackColor: configuration.fallbackColor
            )
        )
    }

    /// Accesses the shape style corresponding to the given key path.
    ///
    /// - Parameter keyPath: The dynamic member key path representing the shape style.
    /// - Returns: A resolved shape style, or the fallback shape style wrapped in `AnyShapeStyle` if not found.
    public subscript(dynamicMember keyPath: String) -> any ShapeStyle {
        guard let representation: SnappThemingGradientRepresentation = self[dynamicMember: keyPath] else {
            return configuration.fallbackColor
        }

        return representation.configuration.shapeStyle
    }
}
