//
//  SnappThemingToggleStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation
import SwiftUI

/// A configuration structure for defining toggle styles in the SnappTheming framework.
public struct SnappThemingToggleStyleConfiguration {
    /// The fallback tint color for the toggle.
    public let fallbackTintColor: Color

    /// The fallback tint color for the toggle when it is disabled.
    public let fallbackDisabledTintColor: Color

    let colors: SnappThemingColorDeclarations
    let colorFormat: SnappThemingColorFormat
}
