//
//  SnappThemingButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 09.01.2025.
//

import SwiftUI

/// A custom `ButtonStyle` that allows for theming based on interactive states such as
/// enabled, selected, and pressed.
///
/// `SnappThemingButtonStyle` provides options to customize the surface color, text color,
/// border color, border width, shape, and font of a button. It dynamically updates
/// its appearance based on the button's state.
///
/// - Note: This style depends on the `Environment` values `isEnabled` and `isSelected`
///   to determine the current state of the button.
public struct SnappThemingButtonStyle: ButtonStyle {
    
    /// The color of the button's surface, supporting interactive states.
    public let surfaceColor: SnappThemingInteractiveColor
    
    /// The color of the button's text, supporting interactive states.
    public let textColor: SnappThemingInteractiveColor
    
    /// The color of the button's border, supporting interactive states.
    public let borderColor: SnappThemingInteractiveColor
    
    /// The width of the button's border.
    public let borderWidth: Double
    
    /// The shape of the button's background and border.
    public let shape: SnappThemingButtonStyleType
    
    /// The font of the button's text.
    public let font: Font
    
    /// Indicates whether the button is currently enabled, derived from the environment.
    @Environment(\.isEnabled) private var isEnabled
    
    /// Indicates whether the button is currently selected, derived from the environment.
    @Environment(\.isSelected) private var isSelected
    
    /// Initializes a new instance of `SnappThemingButtonStyle`.
    ///
    /// - Parameters:
    ///   - surfaceColor: The color of the button's surface for various states.
    ///   - textColor: The color of the button's text for various states.
    ///   - borderColor: The color of the button's border for various states.
    ///   - borderWidth: The width of the button's border.
    ///   - shape: The shape of the button's background and border.
    ///   - font: The font used for the button's text.
    init(
        surfaceColor: SnappThemingInteractiveColor,
        textColor: SnappThemingInteractiveColor,
        borderColor: SnappThemingInteractiveColor,
        borderWidth: Double,
        shape: SnappThemingButtonStyleType,
        font: Font
    ) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shape = shape
        self.font = font
    }
    
    /// Creates the view representing the body of a button.
    ///
    /// - Parameter configuration: The properties of the button being styled.
    /// - Returns: A view that represents the styled button.
    public func makeBody(configuration: Configuration) -> some View {
        let shape = shape.value
        configuration.label
            .font(font)
            .foregroundStyle(
                textColor.value(
                    for: configuration,
                    isEnabled: isEnabled,
                    isSelected: isSelected))
            .padding()
            .background(
                shape.fill(
                    surfaceColor.value(
                        for: configuration,
                        isEnabled: isEnabled,
                        isSelected: isSelected)))
            .overlay(
                shape.stroke(
                    borderColor.value(
                        for: configuration,
                        isEnabled: isEnabled,
                        isSelected: isSelected),
                    lineWidth: borderWidth))
    }
}

private extension SnappThemingInteractiveColor {
    func value(for configuration: ButtonStyle.Configuration, isEnabled: Bool, isSelected: Bool) -> Color {
        guard isEnabled else { return disabled }
        guard !isSelected else { return selected }
        return configuration.isPressed ? pressed : normal
    }
}
