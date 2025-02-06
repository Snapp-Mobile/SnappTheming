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
    /// The colors used in the gradient.
    public let colors: [Color]

    /// The center point of the radial gradient.
    public let center: UnitPoint

    /// The radius at which the radial gradient starts.
    public let startRadius: Double

    /// The radius at which the radial gradient ends.
    public let endRadius: Double
}
