//
//  SnappThemingInteractiveColor.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import SwiftUI

/// A struct representing interactive colors for different states of an element, such as normal, pressed, selected, and disabled.
/// This is commonly used for UI elements that have different color states based on user interaction.
public struct SnappThemingInteractiveColor: Sendable {
    /// The color used in the normal state (when the element is not pressed or selected).
    public let normal: Color

    /// The color used when the element is pressed (tapped or clicked).
    public let pressed: Color
    /// The color used when the element is selected (e.g., highlighted or active).
    public let selected: Color

    /// The color used when the element is disabled (inactive or unresponsive).
    public let disabled: Color

    /// A default clear color for all states, useful for situations where no color is needed.
    static public let clear: Self = .init(normal: .clear, pressed: .clear, selected: .clear, disabled: .clear)

    /// A single color representing the normal state, typically used when only one color is needed.
    public var singleColor: Color {
        normal
    }

    /// Initializes the interactive color with the provided colors for each state.
    /// - Parameters:
    ///   - normal: The color for the normal state.
    ///   - pressed: The color for the pressed state.
    ///   - selected: The color for the selected state.
    ///   - disabled: The color for the disabled state.
    public init(normal: Color, pressed: Color, selected: Color, disabled: Color) {
        self.normal = normal
        self.pressed = pressed
        self.selected = selected
        self.disabled = disabled
    }
}
