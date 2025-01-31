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

    /// The starting angle of the angular gradient in degrees.
    public let startAngle: Angle

    /// The ending angle of the angular gradient in degrees.
    public let endAngle: Angle
}
