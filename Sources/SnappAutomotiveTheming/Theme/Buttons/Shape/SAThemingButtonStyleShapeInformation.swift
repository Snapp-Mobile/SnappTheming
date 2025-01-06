//
//  SAThemingButtonStyleShapeInformation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingButtonStyleShapeInformation: Codable {
    public let width: SAThemingToken<Double>?
    public let height: SAThemingToken<Double>?
    public let cornerRadius: SAThemingToken<Double>
    public let padding: SAThemingToken<[Double]>?
}

public extension SAThemingButtonStyleShapeInformation {
    func resolver(metric: SAThemingMetricDeclarations) -> SAThemingButtonStyleShapeResolver {
        SAThemingButtonStyleShapeResolver(width: width ?? .value(0.0), height: height ?? .value(0.0), cornerRadius: cornerRadius, padding: padding ?? .value([]), metric: metric)
    }
}
