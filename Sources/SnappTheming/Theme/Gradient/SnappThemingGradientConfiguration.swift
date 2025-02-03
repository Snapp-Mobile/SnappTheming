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
    /// The fallback color to use when a specific gradient cannot be resolved.
    public let fallbackColor: Color
    public let fallbackAngle: Angle
    public let fallbackUnitPoint: UnitPoint
    public let fallbackRadius: Double

    // TODO: add fallback for each gradient configuration

    let metrics: SnappThemingMetricDeclarations
    let colors: SnappThemingColorDeclarations
    let colorFormat: SnappThemingColorFormat
}
