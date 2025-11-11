//
//  SnappThemingRadialGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 03.02.2025.
//

import Foundation
import SwiftUI

/// A representation of a radial gradient in the theming system.
///
/// This structure defines the properties required to construct a radial gradient,
/// allowing it to be resolved dynamically based on theming tokens.
public struct SnappThemingRadialGradientRepresentation: Codable {
    /// The colors used in the gradient, represented as theming tokens.
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]

    /// The center point of the gradient.
    public let center: SnappThemingUnitPointWrapper

    /// The starting radius of the gradient, represented as a theming token.
    public let startRadius: SnappThemingToken<Double>

    /// The ending radius of the gradient, represented as a theming token.
    public let endRadius: SnappThemingToken<Double>

    /// Initializes a `SnappThemingRadialGradientRepresentation` with the specified properties.
    ///
    /// - Parameters:
    ///   - colors: An array of `SnappThemingToken` objects, each representing a color in the gradient.
    ///   - center: A `SnappThemingUnitPointWrapper` defining the center point of the gradient.
    ///   - startRadius: A `SnappThemingToken<Double>` representing the starting radius of the gradient.
    ///   - endRadius: A `SnappThemingToken<Double>` representing the ending radius of the gradient.
    public init(
        colors: [SnappThemingToken<SnappThemingColorRepresentation>],
        center: SnappThemingUnitPointWrapper,
        startRadius: SnappThemingToken<Double>,
        endRadius: SnappThemingToken<Double>
    ) {
        self.colors = colors
        self.center = center
        self.startRadius = startRadius
        self.endRadius = endRadius
    }
}

extension SnappThemingRadialGradientRepresentation: SnappThemingGradientProviding {
    /// Creates a `RadialGradient` using the configuration properties.
    ///
    /// This method resolves the radial gradient representation using the given
    /// `SnappThemingGradientConfiguration` and returns a SwiftUI `RadialGradient`
    /// instance that can be applied to a shape.
    ///
    /// - Parameter configuration: The gradient configuration used to resolve colors, radii, and positioning.
    /// - Returns: A `RadialGradient` based on the resolved configuration.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> RadialGradient {
        let radialGradientRepresentation = resolve(using: configuration)
        return RadialGradient(
            colors: radialGradientRepresentation.colors,
            center: radialGradientRepresentation.center,
            startRadius: radialGradientRepresentation.startRadius,
            endRadius: radialGradientRepresentation.endRadius
        )
    }

    /// Resolves the gradient representation using the given configuration.
    ///
    /// This method attempts to resolve the colors and radii based on the provided
    /// `SnappThemingGradientConfiguration`. If resolution fails, it falls back to
    /// default values from the configuration.
    ///
    /// - Parameter configuration: The configuration used to resolve the gradient properties.
    /// - Returns: A `SnappThemingRadialGradientConfiguration` containing the resolved properties.
    public func resolve(using configuration: SnappThemingGradientConfiguration) -> SnappThemingRadialGradientConfiguration {
        let resolvedColors = colors.compactMap {
            configuration.colors.resolver.resolve($0)?.color(using: configuration.colorFormat)
        }
        guard resolvedColors.count == colors.count,
            let startRadius = configuration.metrics.resolver.resolve(startRadius),
            let endRadius = configuration.metrics.resolver.resolve(endRadius)
        else {
            return SnappThemingRadialGradientConfiguration(
                colors: [configuration.fallbackColor],
                center: configuration.fallbackUnitPoint,
                startRadius: configuration.fallbackRadius,
                endRadius: configuration.fallbackRadius
            )
        }

        return SnappThemingRadialGradientConfiguration(
            colors: resolvedColors,
            center: center.value,
            startRadius: startRadius,
            endRadius: endRadius
        )
    }
}
