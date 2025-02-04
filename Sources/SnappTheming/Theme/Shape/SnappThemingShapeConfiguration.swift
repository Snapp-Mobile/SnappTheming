//
//  SnappThemingShapeConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

/// A configuration structure for button style shapes in the SnappTheming framework.
///
/// This struct defines the fallback shape for a button style, providing a default
/// shape configuration in case a specific shape is not available.
public struct SnappThemingShapeConfiguration {
    /// The fallback shape to use when no specific shape is provided.
    public let fallbackShape: any Shape

    /// The default corner radius applied when the shape supports rounded corners.
    public let fallbackCornerRadius: Double

    /// The rounded corner style used when applicable.
    public let fallbackRoundedCornerStyle: RoundedCornerStyle

    public let fallbackCornerRadii: RectangleCornerRadii

    let themeConfiguration: SnappThemingParserConfiguration
    let metrics: SnappThemingMetricDeclarations
}
