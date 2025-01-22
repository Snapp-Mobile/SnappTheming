//
//  SnappThemingButtonStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// A resolver for button style configurations in the SnappTheming framework.
///
/// This struct holds the interactive button style properties such as colors, border, shape, and typography.
/// It is responsible for resolving the appropriate theme for button styles at runtime.
public struct SnappThemingButtonStyleResolver: Sendable {
    // MARK: - Public Properties

    /// The surface color of the button, typically the background color.
    public let surfaceColor: SnappThemingInteractiveColor

    /// The text color used on the button.
    public let textColor: SnappThemingInteractiveColor

    /// The border color of the button.
    public let borderColor: SnappThemingInteractiveColor

    /// The border width of the button.
    public let borderWidth: Double

    /// The shape type of the button, e.g., rounded, rectangle.
    public let shape: SnappThemingShapeType

    /// The typography configuration for the button's text.
    public let typography: SnappThemingTypographyResolver

    // MARK: - Static Methods

    /// Returns a default, empty button style resolver with placeholder values.
    ///
    /// - Returns: A `SnappThemingButtonStyleResolver` instance with default values, such as clear colors and a rectangle shape.
    public static func empty() -> Self {
        .init(
            surfaceColor: .clear,
            textColor: .clear,
            borderColor: .clear,
            borderWidth: 0.0,
            shape: .rectangle,
            typography: SnappThemingTypographyResolver(
                SnappThemingFontResolver(
                    fontName: "SFProText"
                ),
                fontSize: 102.0
            )
        )
    }
}
