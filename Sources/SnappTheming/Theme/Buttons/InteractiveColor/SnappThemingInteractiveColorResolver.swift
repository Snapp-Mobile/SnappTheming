//
//  SnappThemingInteractiveColorResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// A resolver for interactive colors, which resolves the color representations for different states (normal, pressed, disabled)
/// and uses a specified color format and color declarations to determine the interactive colors.
public struct SnappThemingInteractiveColorResolver {
    /// The resolved interactive color, with values for normal, pressed, and disabled states.
    public let interactiveColor: SnappThemingInteractiveColor

    /// Initializes the interactive color resolver with the provided tokens and configuration.
    ///
    /// - Parameters:
    ///   - normal: A token representing the normal state color.
    ///   - pressed: A token representing the pressed state color.
    ///   - disabled: A token representing the disabled state color.
    ///   - colorFormat: The format in which the color should be represented (ARGB or RGBA).
    ///   - colors: The color declarations used to resolve the individual color tokens.
    public init(
        normal: SnappThemingToken<SnappThemingColorRepresentation>,
        pressed: SnappThemingToken<SnappThemingColorRepresentation>,
        disabled: SnappThemingToken<SnappThemingColorRepresentation>,
        colorFormat: SnappThemingColorFormat,
        colors: SnappThemingColorDeclarations
    ) {
        guard let normalColorRepresentation = colors.resolver.resolve(normal) else {
            let aliasName = normal.aliasName ?? "nil"
            runtimeWarning(#file, #line, "Failed to resolve `\(aliasName)` token path.")
            self.interactiveColor = .clear
            return
        }
        guard let pressedColorRepresentation = colors.resolver.resolve(pressed) else {
            let aliasName = pressed.aliasName ?? "nil"
            runtimeWarning(#file, #line, "Failed to resolve `\(aliasName)` token path.")
            self.interactiveColor = SnappThemingInteractiveColor(
                normal: normalColorRepresentation.color(using: colorFormat),
                pressed: .clear,
                disabled: .clear
            )
            return
        }
        guard let disabledColorRepresentation = colors.resolver.resolve(disabled) else {
            let aliasName = pressed.aliasName ?? "nil"
            runtimeWarning(#file, #line, "Failed to resolve `\(aliasName)` token path.")
            self.interactiveColor = SnappThemingInteractiveColor(
                normal: normalColorRepresentation.color(using: colorFormat),
                pressed: pressedColorRepresentation.color(using: colorFormat),
                disabled: .clear
            )
            return
        }
        self.interactiveColor = SnappThemingInteractiveColor(
            normal: normalColorRepresentation.color(using: colorFormat),
            pressed: pressedColorRepresentation.color(using: colorFormat),
            disabled: disabledColorRepresentation.color(using: colorFormat)
        )
    }
}
