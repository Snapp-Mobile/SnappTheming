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
}
