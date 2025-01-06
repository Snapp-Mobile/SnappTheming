//
//  SAThemingInteractiveColor.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import SwiftUI

public struct SAThemingInteractiveColor: Sendable {
    public let normal: Color
    public let pressed: Color
    public let selected: Color
    public let disabled: Color

    static public let clear: Self = .init(normal: .clear, pressed: .clear, selected: .clear, disabled: .clear)

    public var singleColor: Color {
        normal
    }

    init(normal: Color, pressed: Color, selected: Color, disabled: Color) {
        self.normal = normal
        self.pressed = pressed
        self.selected = selected
        self.disabled = disabled
    }
}
