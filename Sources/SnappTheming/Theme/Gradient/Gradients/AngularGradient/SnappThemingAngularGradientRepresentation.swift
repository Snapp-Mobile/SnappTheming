//
//  SnappThemingAngularGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 31.01.2025.
//

import SwiftUI

// TODO: add documentation
public struct SnappThemingAngularGradientRepresentation {
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]
    public let center: SnappThemingUnitPointWrapper
    public let startAngle: SnappThemingToken<Double>
    public let endAngle: SnappThemingToken<Double>
}

extension SnappThemingAngularGradientRepresentation: SnappThemingGradientProviding {
    /// Creates an Angular Gradient shape style using the configuration properties.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> AngularGradient {
        let angularGradientRepresentation = resolve(using: configuration)
        return AngularGradient(
            colors: angularGradientRepresentation.colors,
            center: angularGradientRepresentation.center,
            startAngle: angularGradientRepresentation.startAngle,
            endAngle: angularGradientRepresentation.endAngle
        )
    }

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
