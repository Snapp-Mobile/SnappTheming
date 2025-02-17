//
//  SnappThemingButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 09.01.2025.
//

import SwiftUI

/// A custom `ButtonStyle` that applies theming to the appearance of buttons.
///
/// `SnappThemingButtonStyle` allows for the application of a theming system to buttons, including surface colors,
/// text colors, border colors, border width, button shape, and font. It ensures that the button appearance adapts
/// based on the theming configuration and whether the button is enabled or disabled.
///
/// - Note: This button style is designed to work seamlessly with the theming system,
///   allowing buttons to reflect the current theme's design system in a consistent manner.
public struct SnappThemingButtonStyle: ButtonStyle {
    /// The current state of the button, indicating if it is enabled.
    @Environment(\.isEnabled) private var isEnabled

    /// The background color of the button (e.g., surface color).
    public let surfaceColor: SnappThemingInteractiveColor

    /// The color used for the button's text.
    public let textColor: SnappThemingInteractiveColor

    /// The color used for the button's border.
    public let borderColor: SnappThemingInteractiveColor

    /// The width of the button's border.
    public let borderWidth: Double

    /// The shape type applied to the button (e.g., rounded, square).
    public let shapeType: SnappThemingShapeType

    /// The font used for the button's label.
    public let font: Font

    /// Initializes a new instance of `SnappThemingButtonStyle`.
    ///
    /// - Parameters:
    ///   - surfaceColor: The background color of the button, typically representing its surface.
    ///   - textColor: The color used for the button's text.
    ///   - borderColor: The color used for the button's border.
    ///   - borderWidth: The width of the button's border.
    ///   - shapeType: The shape type to apply to the button's border (e.g., rounded corners).
    ///   - font: The font to apply to the button's label.
    public init(
        surfaceColor: SnappThemingInteractiveColor,
        textColor: SnappThemingInteractiveColor,
        borderColor: SnappThemingInteractiveColor,
        borderWidth: Double,
        shapeType: SnappThemingShapeType,
        font: Font
    ) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shapeType = shapeType
        self.font = font
    }

    /// Creates the body of the button using the specified configuration.
    ///
    /// - Parameter configuration: The configuration object containing the button's label and state.
    /// - Returns: A view representing the button with applied styles.
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .foregroundStyle(textColor.value(for: configuration, isEnabled: isEnabled))
            .padding()
            .background(shapeType.shape.fill(surfaceColor.value(for: configuration, isEnabled: isEnabled)))
            .overlay(shapeType.shape.stroke(borderColor.value(for: configuration, isEnabled: isEnabled), lineWidth: borderWidth))
    }
}

extension SnappThemingInteractiveColor {
    fileprivate func value(for configuration: ButtonStyle.Configuration, isEnabled: Bool) -> Color {
        switch (configuration.isPressed, isEnabled) {
        case (_, false): disabled
        case (true, true): pressed
        case (false, true): normal
        }
    }
}
