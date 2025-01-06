//
//  SAThemingInteractiveColorResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingInteractiveColorResolver {
    public let interactiveColor: SAThemingInteractiveColor
    public init(
        normal: SAThemingToken<SAThemingColorRepresentation>,
        pressed: SAThemingToken<SAThemingColorRepresentation>,
        selected: SAThemingToken<SAThemingColorRepresentation>,
        disabled: SAThemingToken<SAThemingColorRepresentation>,
        colorFormat: SAThemingColorFormat,
        colors: SAThemingColorDeclarations
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
        self.interactiveColor = SAThemingInteractiveColor(
            normal: normal.color(using: colorFormat),
            pressed: pressed.color(using: colorFormat),
            selected: selected.color(using: colorFormat),
            disabled: disabled.color(using: colorFormat)
        )
    }
}
