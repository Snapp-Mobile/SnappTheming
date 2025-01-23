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
    /// The fallback button shape type to use when no specific shape is defined.
    public let fallbackShape: SnappThemingShapeType

    /// The configuration used for parsing and applying theming.
    let themeConfiguration: SnappThemingParserConfiguration
}
