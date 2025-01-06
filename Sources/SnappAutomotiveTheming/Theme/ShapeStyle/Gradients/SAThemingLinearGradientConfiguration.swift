//
//  SAThemingLinearGradientConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

public struct SAThemingLinearGradientConfiguration: Sendable {
    public let colors: [Color]
    public let startPoint: UnitPoint
    public let endPoint: UnitPoint
    private let colorDescriptions: [String]

    enum CodingKeys: CodingKey {
        case colors, startPoint, endPoint
    }
}

extension SAThemingLinearGradientConfiguration: SAThemingShapeStyleProviding {
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
        self.colors = colorsDescription.compactMap { Color(hex: $0) }
        self.startPoint = try container.decode(SAThemingUnitPointWrapper.self, forKey: .startPoint).value
        self.endPoint = try container.decode(SAThemingUnitPointWrapper.self, forKey: .endPoint).value
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorDescriptions, forKey: .colors)
        try container.encode(SAThemingUnitPointWrapper(value: startPoint), forKey: .startPoint)
        try container.encode(SAThemingUnitPointWrapper(value: endPoint), forKey: .endPoint)
    }
}
