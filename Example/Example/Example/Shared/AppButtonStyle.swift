//
//  AppButtonStyle.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import SwiftUI
import SnappTheming

struct AppButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    var selected: Bool = false
    let style: SnappThemingButtonStyleResolver
    let width: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(style.typography.font)
            .foregroundStyle(
                style.textColor.activeColor(when: configuration.isPressed, isSelected: selected, isDisabled: !isEnabled)
            )
            .padding()
            .frame(minWidth: width, minHeight: 64)
            .background(
                style.shape.value
                    .fill(
                        style.surfaceColor
                            .activeColor(when: configuration.isPressed, isSelected: selected, isDisabled: !isEnabled)
                    )
            )
            .overlay(
                style.shape.value
                    .stroke(
                        style.borderColor.activeColor(
                            when: configuration.isPressed,
                            isSelected: selected,
                            isDisabled: !isEnabled
                        ),
                        lineWidth: style.borderWidth
                    )
            )
    }
}

extension SnappThemingInteractiveColor {
    func activeColor(when isPressed: Bool = false, isSelected: Bool = false, isDisabled: Bool = false) -> Color {
        if isDisabled {
            return disabled
        } else if isPressed {
            return pressed
        } else if isSelected {
            return selected
        } else {
            return normal
        }
    }
}
