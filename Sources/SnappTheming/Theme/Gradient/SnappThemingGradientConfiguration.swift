//
//  SnappThemingGradientConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation
import SwiftUI

/// Configuration for resolving gradients in the theming system.
public struct SnappThemingGradientConfiguration {
    /// The fallback color to use when a gradient cannot be resolved.
    public let fallbackColor: Color

    /// The fallback angle, typically used for linear gradients.
    public let fallbackAngle: Angle

    /// The fallback unit point, representing the start or end position of a gradient.
    public let fallbackUnitPoint: UnitPoint

    /// The fallback radius, typically used for radial gradients.
    public let fallbackRadius: Double

    let metrics: SnappThemingMetricDeclarations
    let colors: SnappThemingColorDeclarations
    let colorFormat: SnappThemingColorFormat
}
