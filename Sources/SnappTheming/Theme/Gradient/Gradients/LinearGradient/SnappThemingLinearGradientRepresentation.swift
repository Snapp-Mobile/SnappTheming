//
//  SnappThemingLinearGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 31.01.2025.
//

import SwiftUI

public struct SnappThemingLinearGradientRepresentation: Codable {
    public let colors: [SnappThemingToken<SnappThemingColorRepresentation>]
    public let startPoint: SnappThemingUnitPointWrapper
    public let endPoint: SnappThemingUnitPointWrapper
}

extension SnappThemingLinearGradientRepresentation: SnappThemingGradientProviding {
    /// Creates a Linear Gradient shape style using the configuration properties.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> LinearGradient {
        let linearGradientConfiguration = resolve(using: configuration)
        return LinearGradient(
            colors: linearGradientConfiguration.colors,
            startPoint: linearGradientConfiguration.startPoint,
            endPoint: linearGradientConfiguration.endPoint
        )
    }

    public func resolve(using configuration: SnappThemingGradientConfiguration) -> SnappThemingLinearGradientConfiguration {
        let resolvedColors = colors.compactMap {
            configuration.colors.resolver.resolve($0)?.color(using: .rgba)
        }
        guard resolvedColors.count == colors.count else {
            return SnappThemingLinearGradientConfiguration(
                colors: [configuration.fallbackColor],
                startPoint: startPoint.value,
                endPoint: endPoint.value
            )
        }

        return SnappThemingLinearGradientConfiguration(
            colors: resolvedColors,
            startPoint: startPoint.value,
            endPoint: endPoint.value
        )
    }
}
