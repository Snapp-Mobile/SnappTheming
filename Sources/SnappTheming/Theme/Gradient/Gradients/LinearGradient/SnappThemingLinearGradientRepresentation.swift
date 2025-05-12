//
//  SnappThemingLinearGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 31.01.2025.
//

import SwiftUI

/// A representation of a linear gradient in the theming system.
///
/// This structure defines the properties required to construct a linear gradient, allowing it to be resolved dynamically based on theming tokens.
public struct SnappThemingLinearGradientRepresentation: Codable {
    /// The colors used in the gradient, represented as theming tokens.
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]

    /// The starting point of the gradient.
    public let startPoint: SnappThemingUnitPointWrapper

    /// The ending point of the gradient.
    public let endPoint: SnappThemingUnitPointWrapper

    /// Initializes a `SnappThemingLinearGradientRepresentation` with the specified properties.
    ///
    /// - Parameters:
    ///   - colors: An array of `SnappThemingToken` objects, each representing a color in the gradient.
    ///   - startPoint: A `SnappThemingUnitPointWrapper` defining the starting point of the gradient.
    ///   - endPoint: A `SnappThemingUnitPointWrapper` defining the ending point of the gradient.
    public init(
        colors: [SnappThemingToken<SnappThemingColorRepresentation>],
        startPoint: SnappThemingUnitPointWrapper,
        endPoint: SnappThemingUnitPointWrapper
    ) {
        self.colors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}

extension SnappThemingLinearGradientRepresentation: SnappThemingGradientProviding {
    /// Creates a `LinearGradient` using the configuration properties.
    ///
    /// This method resolves the linear gradient representation using the given
    /// `SnappThemingGradientConfiguration` and returns a SwiftUI `LinearGradient` instance that can be applied to a shape.
    ///
    /// - Parameter configuration: The gradient configuration used to resolve colors and positioning.
    /// - Returns: A `LinearGradient` based on the resolved configuration.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> LinearGradient {
        let linearGradientConfiguration = resolve(using: configuration)
        return LinearGradient(
            colors: linearGradientConfiguration.colors,
            startPoint: linearGradientConfiguration.startPoint,
            endPoint: linearGradientConfiguration.endPoint
        )
    }

    /// Resolves the gradient representation using the given configuration.
    ///
    /// This method attempts to resolve the colors based on the provided
    /// `SnappThemingGradientConfiguration`. If resolution fails, it falls back to default values from the configuration.
    ///
    /// - Parameter configuration: The configuration used to resolve the gradient properties.
    /// - Returns: A `SnappThemingLinearGradientConfiguration` containing the resolved properties.
    public func resolve(using configuration: SnappThemingGradientConfiguration) -> SnappThemingLinearGradientConfiguration {
        let resolvedColors = colors.compactMap {
            configuration.colors.resolver.resolve($0)?.color(using: .rgba)
        }
        guard resolvedColors.count == colors.count else {
            return SnappThemingLinearGradientConfiguration(
                colors: [configuration.fallbackColor],
                startPoint: configuration.fallbackUnitPoint,
                endPoint: configuration.fallbackUnitPoint
            )
        }

        return SnappThemingLinearGradientConfiguration(
            colors: resolvedColors,
            startPoint: startPoint.value,
            endPoint: endPoint.value
        )
    }
}
