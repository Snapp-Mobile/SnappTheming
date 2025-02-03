//
//  SnappThemingRadialGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 03.02.2025.
//

import Foundation
import SwiftUI

public struct SnappThemingRadialGradientRepresentation: Codable {
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]
    public let center: SnappThemingUnitPointWrapper
    public let startRadius: SnappThemingToken<Double>
    public let endRadius: SnappThemingToken<Double>
}

extension SnappThemingRadialGradientRepresentation: SnappThemingGradientProviding {
    /// Creates a radial gradient shape style using the configuration properties.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> RadialGradient {
        let radialGradientRepresentation = resolve(using: configuration)
        return RadialGradient(
            colors: radialGradientRepresentation.colors,
            center: radialGradientRepresentation.center,
            startRadius: radialGradientRepresentation.startRadius,
            endRadius: radialGradientRepresentation.endRadius
        )
    }

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

