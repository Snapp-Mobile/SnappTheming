//
//  SnappThemingToggleStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

/// A resolver that provides the tint color and disabled tint color for toggle styles.
public struct SnappThemingToggleStyleResolver {
    /// The tint color for the toggle in its active (enabled) state.
    public let tintColor: Color

    /// The tint color for the toggle when it is disabled.
    public let disabledTintColor: Color
}

public extension SnappThemingToggleStyleResolver {
    /// A static method to return a `SnappThemingToggleStyleResolver` with default clear colors.
    ///
    /// - Returns: A `SnappThemingToggleStyleResolver` instance with `tintColor` and `disabledTintColor` set to `.clear`.
    static func empty() -> Self {
        SnappThemingToggleStyleResolver(
            tintColor: .clear,
            disabledTintColor: .clear
        )
    }
}
