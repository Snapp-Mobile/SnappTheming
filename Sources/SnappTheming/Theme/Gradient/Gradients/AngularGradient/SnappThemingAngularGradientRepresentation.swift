//
//  SnappThemingAngularGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 31.01.2025.
//

import SwiftUI

/// Representation of an angular gradient.
public struct SnappThemingAngularGradientRepresentation {
    /// The colors used in the gradient, represented as theming tokens.
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]

    /// The center point of the gradient.
    public let center: SnappThemingUnitPointWrapper

    /// The starting angle of the gradient, represented as a theming token.
    public let startAngle: SnappThemingToken<Double>

    /// The ending angle of the gradient, represented as a theming token.
    public let endAngle: SnappThemingToken<Double>

    /// Initializes a `SnappThemingAngularGradientRepresentation` with the specified properties.
    ///
    /// - Parameters:
    ///   - colors: An array of `SnappThemingToken` objects, each representing a color in the gradient.
    ///   - center: A `SnappThemingUnitPointWrapper` defining the center point of the gradient.
    ///   - startAngle: A `SnappThemingToken<Double>` representing the starting angle of the gradient in degrees.
    ///   - endAngle: A `SnappThemingToken<Double>` representing the ending angle of the gradient in degrees.
    public init(
        colors: [SnappThemingToken<SnappThemingColorRepresentation>],
        center: SnappThemingUnitPointWrapper,
        startAngle: SnappThemingToken<Double>,
        endAngle: SnappThemingToken<Double>
    ) {
        self.colors = colors
        self.center = center
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}

extension SnappThemingAngularGradientRepresentation: SnappThemingGradientProviding {
    /// Creates an `AngularGradient` using the configuration properties.
    ///
    /// This method resolves the angular gradient representation using the given
    /// `SnappThemingGradientConfiguration` and returns a SwiftUI `AngularGradient` instance that can be applied to a shape.
    ///
    /// - Parameter configuration: The gradient configuration used to resolve colors, angles, and positioning.
    /// - Returns: An `AngularGradient` based on the resolved configuration.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> AngularGradient {
        let angularGradientRepresentation = resolve(using: configuration)
        return AngularGradient(
            colors: angularGradientRepresentation.colors,
            center: angularGradientRepresentation.center,
            startAngle: angularGradientRepresentation.startAngle,
            endAngle: angularGradientRepresentation.endAngle
        )
    }

    /// Resolves the gradient representation using the given configuration.
    ///
    /// This method attempts to resolve the colors and angles based on the provided
    /// `SnappThemingGradientConfiguration`. If resolution fails, it falls back to default values from the configuration.
    ///
    /// - Parameter configuration: The configuration used to resolve the gradient properties.
    /// - Returns: A `SnappThemingAngularGradientConfiguration` containing the resolved properties.
    public func resolve(using configuration: SnappThemingGradientConfiguration) -> SnappThemingAngularGradientConfiguration {
        let resolvedColors = colors.compactMap {
            configuration.colors.resolver.resolve($0)?.color(using: configuration.colorFormat)
        }
        guard resolvedColors.count == colors.count,
            let startAngle = configuration.metrics.resolver.resolve(startAngle),
            let endAngle = configuration.metrics.resolver.resolve(endAngle)
        else {
            return SnappThemingAngularGradientConfiguration(
                colors: [configuration.fallbackColor],
                center: configuration.fallbackUnitPoint,
                startAngle: configuration.fallbackAngle,
                endAngle: configuration.fallbackAngle
            )
        }

        return SnappThemingAngularGradientConfiguration(
            colors: resolvedColors,
            center: center.value,
            startAngle: Angle(degrees: startAngle),
            endAngle: Angle(degrees: endAngle)
        )
    }
}
