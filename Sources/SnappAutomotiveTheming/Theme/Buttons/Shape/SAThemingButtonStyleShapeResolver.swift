//
//  SAThemingButtonStyleShapeResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingButtonStyleShapeResolver {
    public let shape: SAThemingButtonStyleShape
    public init(
        width: SAThemingToken<Double>,
        height: SAThemingToken<Double>,
        cornerRadius: SAThemingToken<Double>,
        padding: SAThemingToken<[Double]>,
        metric: SAThemingMetricDeclarations
    ) {
        guard
            let width = metric.resolver.resolve(width),
            let height = metric.resolver.resolve(height),
            let cornerRadius = metric.resolver.resolve(cornerRadius),
            let padding = padding.value
        else {
            self.shape = .init()
            return
        }
        self.shape = SAThemingButtonStyleShape(
            width: width,
            height: height,
            cornerRadius: cornerRadius,
            padding: padding
        )
    }
}
