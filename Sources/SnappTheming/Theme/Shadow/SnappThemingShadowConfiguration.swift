//
//  SnappThemingShadowConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import Foundation
import SwiftUI

/// Configuration for theming shadow.
///
/// This struct holds fallback data for shadow in case of any of properties are not provided.
public struct SnappThemingShadowConfiguration {
    //  MARK: - Public properties

    /// The fallback color used when a shadow's color cannot be resolved.
    ///
    /// This color is applied to shadows when the theming system cannot resolve
    /// the specified color token from the color declarations.
    public let fallbackColor: Color

    /// The fallback blur radius used when a shadow's radius cannot be resolved.
    ///
    /// This radius value is applied to shadows when the theming system cannot resolve
    /// the specified radius token from the metric declarations.
    public let fallbackRadius: Double

    /// The fallback horizontal offset used when a shadow's x-offset cannot be resolved.
    ///
    /// This x-offset value is applied to shadows when the theming system cannot resolve
    /// the specified x-offset token from the metric declarations.
    public let fallbackX: Double

    /// The fallback vertical offset used when a shadow's y-offset cannot be resolved.
    ///
    /// This y-offset value is applied to shadows when the theming system cannot resolve
    /// the specified y-offset token from the metric declarations.
    public let fallbackY: Double

    /// The fallback spread radius used when a shadow's spread cannot be resolved.
    ///
    /// This spread value is applied to shadows when the theming system cannot resolve
    /// the specified spread token from the metric declarations.
    public let fallbackSpread: Double

    //  MARK: - Internal properties

    let metrics: SnappThemingMetricDeclarations
    let colors: SnappThemingColorDeclarations
    let colorFormat: SnappThemingColorFormat
}
