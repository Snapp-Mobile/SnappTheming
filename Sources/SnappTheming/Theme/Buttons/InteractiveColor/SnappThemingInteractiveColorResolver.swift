//
//  SnappThemingInteractiveColorResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// A resolver for interactive colors, which resolves the color representations for different states (normal, pressed, selected, disabled)
/// and uses a specified color format and color declarations to determine the interactive colors.
public struct SnappThemingInteractiveColorResolver {
    /// The resolved interactive color, with values for normal, pressed, selected, and disabled states.
    public let interactiveColor: SnappThemingInteractiveColor

    /// Initializes the interactive color resolver with the provided tokens and configuration.
    ///
    /// - Parameters:
    ///   - normal: A token representing the normal state color.
    ///   - pressed: A token representing the pressed state color.
    ///   - selected: A token representing the selected state color.
    ///   - disabled: A token representing the disabled state color.
    ///   - colorFormat: The format in which the color should be represented (ARGB or RGBA).
    ///   - colors: The color declarations used to resolve the individual color tokens.
    public init(
        normal: SnappThemingToken<SnappThemingColorRepresentation>,
        pressed: SnappThemingToken<SnappThemingColorRepresentation>,
        selected: SnappThemingToken<SnappThemingColorRepresentation>,
        disabled: SnappThemingToken<SnappThemingColorRepresentation>,
        colorFormat: SnappThemingColorFormat,
        colors: SnappThemingColorDeclarations
    ) {
        guard
            let normal = colors.resolver.resolve(normal),
            let pressed = colors.resolver.resolve(pressed),
            let selected = colors.resolver.resolve(selected),
            let disabled = colors.resolver.resolve(disabled)
        else {
            self.interactiveColor = .clear
            return
        }
        self.interactiveColor = SnappThemingInteractiveColor(
            normal: normal.color(using: colorFormat),
            pressed: pressed.color(using: colorFormat),
            selected: selected.color(using: colorFormat),
            disabled: disabled.color(using: colorFormat)
        )
    }
}
