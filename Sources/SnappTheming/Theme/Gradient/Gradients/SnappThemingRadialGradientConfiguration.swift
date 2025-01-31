//
//  SnappThemingRadialGradientConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import SwiftUI

/// A configuration for creating a radial gradient shape style.
///
/// This configuration defines the properties required to construct a radial gradient,
/// including its colors, center point, and radius values.
public struct SnappThemingRadialGradientConfiguration: Sendable {
    /// The center point of the radial gradient.
    public let center: UnitPoint

    /// The radius at which the radial gradient starts.
    public let startRadius: Double

    /// The radius at which the radial gradient ends.
    public let endRadius: Double

    /// The colors used in the gradient.
    public let colors: [Color]
    private let colorDescriptions: [String]

    enum CodingKeys: CodingKey {
        case colors, center, startRadius, endRadius
    }
}

extension SnappThemingRadialGradientConfiguration: SnappThemingGradientProviding {
    /// Creates a radial gradient shape style using the configuration properties.
    public func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> RadialGradient {
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
        self.colors = colorDescriptions.map { Color(hex: $0) }
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
