//
//  SnappThemingRadialGradientConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

public struct SnappThemingRadialGradientConfiguration: Sendable {
    public let center: UnitPoint
    public let startRadius: Double
    public let endRadius: Double
    public let colors: [Color]
    private let colorDescriptions: [String]

    enum CodingKeys: CodingKey {
        case colors, center, startRadius, endRadius
    }
}

extension SnappThemingRadialGradientConfiguration: SnappThemingShapeStyleProviding {
    public var shapeStyle: some ShapeStyle {
        RadialGradient(
            colors: colors,
            center: center,
            startRadius: startRadius,
            endRadius: endRadius
        )
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let colorDescriptions = try container.decode([String].self, forKey: .colors)
        self.colorDescriptions = colorDescriptions
        self.colors = colorDescriptions.compactMap { Color(hex: $0) }
        self.center = try container.decode(SnappThemingUnitPointWrapper.self, forKey: .center).value
        self.startRadius = try container.decode(Double.self, forKey: .startRadius)
        self.endRadius = try container.decode(Double.self, forKey: .endRadius)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorDescriptions, forKey: .colors)
        try container.encode(SnappThemingUnitPointWrapper(value: center), forKey: .center)
        try container.encode(startRadius, forKey: .startRadius)
        try container.encode(endRadius, forKey: .endRadius)
    }
}
