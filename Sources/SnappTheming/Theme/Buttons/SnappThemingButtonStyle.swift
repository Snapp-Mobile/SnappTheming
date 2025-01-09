//
//  SnappThemingButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 09.01.2025.
//


import SwiftUI

public struct SnappThemingButtonStyle: ButtonStyle {
    public let style: SnappThemingButtonStyleResolver
    public let isSelected: Bool

    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        let shape = style.shape.value
        configuration.label
            .font(style.typography.font)
            .foregroundStyle(
                style.textColor.value(
                    for: configuration,
                    isEnabled: isEnabled,
                    isSelected: isSelected))
            .padding()
            .background(
                shape.fill(
                    style.surfaceColor.value(
                        for: configuration,
                        isEnabled: isEnabled,
                        isSelected: isSelected)))
            .overlay(
                shape.stroke(
                    style.borderColor.value(
                        for: configuration,
                        isEnabled: isEnabled,
                        isSelected: isSelected),
                    lineWidth: style.borderWidth))
    }
}

private extension SnappThemingInteractiveColor {
    func value(for configuration: ButtonStyle.Configuration, isEnabled: Bool, isSelected: Bool) -> Color {
        guard isEnabled else { return disabled }
 
        return switch (configuration.isPressed, isSelected) {
        case (_, true): selected
        case (true, _): pressed
        case (_, _): normal
        }
    }
}

public extension SnappThemingButtonStyleResolver {
    var normal: some ButtonStyle {
        SnappThemingButtonStyle(style: self, isSelected: false)
    }

    var selected: some ButtonStyle {
        SnappThemingButtonStyle(style: self, isSelected: true)
    }
}
