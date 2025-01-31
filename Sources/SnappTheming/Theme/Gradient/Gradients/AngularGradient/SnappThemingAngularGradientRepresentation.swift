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
    public let startAngle: Double
    public let endAngle: Double
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
            configuration.colors.resolver.resolve($0)?.color(using: .rgba)
        }
        guard resolvedColors.count == colors.count else {
            return SnappThemingAngularGradientConfiguration(
                colors: [configuration.fallbackColor],
                center: center.value,
                startAngle: Angle(degrees: startAngle),
                endAngle: Angle(degrees: endAngle)
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
