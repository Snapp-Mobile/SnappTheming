//
//  SnappThemingTypographyConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation

/// Configuration for resolving typography in the SnappTheming framework.
public struct SnappThemingTypographyConfiguration {
    /// Fallback font size to use when a specific typography size cannot be resolved.
    let fallbackFontSize: CGFloat
    /// A declaration of font-related theming configurations.
    let fonts: SnappThemingFontDeclarations
    /// A declaration of metric-related theming configurations.
    let metrics: SnappThemingMetricDeclarations
}
