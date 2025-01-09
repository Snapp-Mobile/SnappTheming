//
//  SnappThemingButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 09.01.2025.
//


import SwiftUI

public struct SnappThemingButtonStyle: ButtonStyle {
    public let surfaceColor: SnappThemingInteractiveColor
    public let textColor: SnappThemingInteractiveColor
    public let borderColor: SnappThemingInteractiveColor
    public let borderWidth: Double
    public let shape: SnappThemingButtonStyleType
    public let font: Font

    init(
        surfaceColor: SnappThemingInteractiveColor,
        textColor: SnappThemingInteractiveColor,
        borderColor: SnappThemingInteractiveColor,
        borderWidth: Double,
        shape: SnappThemingButtonStyleType,
        font: Font
    ) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shape = shape
        self.font = font
    }

    @Environment(\.isEnabled) private var isEnabled

    public func makeBody(configuration: Configuration) -> some View {
        let shape = shape.value
        configuration.label
            .font(font)
            .foregroundStyle(textColor.value(for: configuration, isEnabled: isEnabled))
            .padding()
            .background(shape.fill(surfaceColor.value(for: configuration, isEnabled: isEnabled)))
            .overlay(shape.stroke(borderColor.value(for: configuration, isEnabled: isEnabled), lineWidth: borderWidth))
    }
}

private extension SnappThemingInteractiveColor {
    func value(for configuration: ButtonStyle.Configuration, isEnabled: Bool) -> Color {
        switch (configuration.isPressed, isEnabled) {
        case (_, false): disabled
        case (true, true): pressed
        case (false, true): normal
        }
    }
}
