//
//  SnappThemingGradientDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import SwiftUI

public typealias SnappThemingGradientDeclarations = SnappThemingDeclarations<
    SnappThemingGradientRepresentation,
    SnappThemingGradientConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingGradientRepresentation,
    Configuration == SnappThemingGradientConfiguration
{
    /// Initializes the declarations for resolving shape styles in the theming system.
    ///
    /// - Parameters:
    ///   - cache: An optional cache of theming tokens for shape styles.
    ///   - configuration: The parser configuration, defaulting to `.default`.
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        metrics: SnappThemingMetricDeclarations,
        colors: SnappThemingColorDeclarations,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(
            cache: cache,
            rootKey: .gradients,
            configuration: Configuration(
                fallbackColor: configuration.fallbackColor,
                fallbackAngle: configuration.fallbackGradientAngle,
                fallbackUnitPoint: configuration.fallbackGradientUnitPoint,
                fallbackRadius: configuration.fallbackGradientRadius,
                metrics: metrics,
                colors: colors,
                colorFormat: configuration.colorFormat
            )
        )
    }

    /// Accesses the shape style corresponding to the given key path.
    ///
    /// - Parameter keyPath: The dynamic member key path representing the shape style.
    /// - Returns: A resolved shape style, or the fallback shape style.
    public subscript(dynamicMember keyPath: String) -> some ShapeStyle {
        if let representation = cache[keyPath]?.value {
            AnyShapeStyle(representation.configuration.shapeStyleUsing(configuration))
        } else {
            AnyShapeStyle(configuration.fallbackColor)
        }
    }
}
