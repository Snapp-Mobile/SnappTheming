//
//  SAThemingAngularGradientConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

public struct SAThemingAngularGradientConfiguration: Sendable {
    public let colors: [Color]
    public let center: UnitPoint
    public let startAngle: Angle
    public let endAngle: Angle
    private var colorDescriptions: [String]

    enum CodingKeys: CodingKey {
        case colors, center, startAngle, endAngle
    }
}

extension SAThemingAngularGradientConfiguration: SAThemingShapeStyleProviding {
    public var shapeStyle: some ShapeStyle {
        AngularGradient(
            colors: colors,
            center: center,
            startAngle: startAngle,
            endAngle: endAngle
        )
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let colorDescriptions = try container.decode([String].self, forKey: .colors)
        self.colorDescriptions = colorDescriptions
        self.colors = colorDescriptions.compactMap { Color(hex: $0) }
        self.center = try container.decode(SAThemingUnitPointWrapper.self, forKey: .center).value
        let startAngle = try container.decode(Double.self, forKey: .startAngle)
        let endAngle = try container.decode(Double.self, forKey: .endAngle)
        self.startAngle = Angle(degrees: startAngle)
        self.endAngle = Angle(degrees: endAngle)

    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorDescriptions, forKey: .colors)
        try container.encode(SAThemingUnitPointWrapper(value: center), forKey: .center)
        try container.encode(startAngle.degrees, forKey: .startAngle)
        try container.encode(endAngle.degrees, forKey: .endAngle)
    }
}
