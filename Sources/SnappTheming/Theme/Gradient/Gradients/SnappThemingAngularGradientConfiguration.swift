//
//  SnappThemingAngularGradientConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

/// A configuration for creating an Angular Gradient shape style.
///
/// This configuration provides the necessary parameters to define an angular gradient,
/// including its colors, center point, and angle ranges.
public struct SnappThemingAngularGradientConfiguration: Sendable {
    /// The colors used in the gradient.
    public let colors: [Color]

    /// The center point of the angular gradient.
    public let center: UnitPoint

    /// The starting angle of the angular gradient.
    public let startAngle: Angle

    /// The ending angle of the angular gradient.
    public let endAngle: Angle

    private var colorDescriptions: [String]

    public enum CodingKeys: CodingKey {
        case colors, center, startAngle, endAngle
    }
}

extension SnappThemingAngularGradientConfiguration: SnappThemingGradientProviding {
    /// Creates an Angular Gradient shape style using the configuration properties.
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
        self.colors = colorDescriptions.map { Color(hex: $0) }
        self.center = try container.decode(SnappThemingUnitPointWrapper.self, forKey: .center).value
        let startAngle = try container.decode(Double.self, forKey: .startAngle)
        let endAngle = try container.decode(Double.self, forKey: .endAngle)
        self.startAngle = Angle(degrees: startAngle)
        self.endAngle = Angle(degrees: endAngle)

    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorDescriptions, forKey: .colors)
        try container.encode(SnappThemingUnitPointWrapper(value: center), forKey: .center)
        try container.encode(startAngle.degrees, forKey: .startAngle)
        try container.encode(endAngle.degrees, forKey: .endAngle)
    }
}
