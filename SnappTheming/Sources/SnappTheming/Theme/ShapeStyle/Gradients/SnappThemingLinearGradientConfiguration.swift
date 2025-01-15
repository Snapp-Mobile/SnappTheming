//
//  SnappThemingLinearGradientConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

/// A configuration for creating a linear gradient shape style.
///
/// This configuration provides the properties required to define a linear gradient,
/// including its colors, start point, and end point.
public struct SnappThemingLinearGradientConfiguration: Sendable {
    /// The colors used in the linear gradient.
    public let colors: [Color]

    /// The starting point of the linear gradient.
    public let startPoint: UnitPoint

    /// The ending point of the linear gradient.
    public let endPoint: UnitPoint

    private let colorDescriptions: [String]

    enum CodingKeys: CodingKey {
        case colors, startPoint, endPoint
    }
}

extension SnappThemingLinearGradientConfiguration: SnappThemingShapeStyleProviding {
    /// Creates a Linear Gradient shape style using the configuration properties.
    public var shapeStyle: some ShapeStyle {
        LinearGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let colorsDescription = try container.decode([String].self, forKey: .colors)
        self.colorDescriptions = colorsDescription
        self.colors = colorsDescription.map { Color(hex: $0) }
        self.startPoint = try container.decode(SnappThemingUnitPointWrapper.self, forKey: .startPoint).value
        self.endPoint = try container.decode(SnappThemingUnitPointWrapper.self, forKey: .endPoint).value
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorDescriptions, forKey: .colors)
        try container.encode(SnappThemingUnitPointWrapper(value: startPoint), forKey: .startPoint)
        try container.encode(SnappThemingUnitPointWrapper(value: endPoint), forKey: .endPoint)
    }
}
