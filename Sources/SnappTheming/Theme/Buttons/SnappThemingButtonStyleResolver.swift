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

    // MARK: - Initializer

    /// Initializes a new `SnappThemingButtonStyleResolver` with the given properties.
    ///
    /// - Parameters:
    ///   - surfaceColor: The button's surface (background) color.
    ///   - textColor: The button's text color.
    ///   - borderColor: The color of the button's border.
    ///   - borderWidth: The width of the button's border.
    ///   - shape: The shape of the button.
    ///   - typography: The typography configuration for the button's text.
    init(
        surfaceColor: SnappThemingInteractiveColor,
        textColor: SnappThemingInteractiveColor,
        borderColor: SnappThemingInteractiveColor,
        borderWidth: Double,
        shape: SnappThemingShapeType,
        typography: SnappThemingTypographyResolver
    ) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shape = shape
        self.typography = typography
    }

    // MARK: - Static Methods

    /// Returns a default, empty button style resolver with placeholder values.
    ///
    /// - Returns: A `SnappThemingButtonStyleResolver` instance with default values, such as clear colors and a rectangle shape.
    public static func empty() -> Self {
        SnappThemingButtonStyleResolver(
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
