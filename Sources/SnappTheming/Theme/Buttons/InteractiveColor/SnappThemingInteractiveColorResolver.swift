//
//  SnappThemingInteractiveColorResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SnappThemingInteractiveColorResolver {
    public let interactiveColor: SnappThemingInteractiveColor
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
