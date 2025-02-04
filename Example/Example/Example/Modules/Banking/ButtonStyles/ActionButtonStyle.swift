//
//  ActionButtonStyle.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation
import SnappTheming
import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.labelStyle(
            ActionButtonLabelStyle(isPressed: configuration.isPressed))
    }

    private struct ActionButtonLabelStyle: LabelStyle {
        private let isPressed: Bool
        @Environment(\.isEnabled) private var isEnabled
        @Environment(Theme.self) private var theme

        init(isPressed: Bool) {
            self.isPressed = isPressed
        }

        func makeBody(configuration: Configuration) -> some View {
            let style: SnappThemingButtonStyleResolver = theme
                .buttonStyles.action
            let iconSize = theme.metrics.iconSize
            let buttonSize = theme.metrics.buttonSize
            VStack(spacing: theme.metrics.small) {
                ZStack {
                    configuration.icon
                        .frame(width: iconSize, height: iconSize)
                }
                .frame(width: buttonSize, height: buttonSize)
                .background(
                    style.surfaceColor.color(
                        isPressed: isPressed,
                        isEnabled: isEnabled)
                )
                .clipShape(style.shape.value)
                .shadow(
                    color: theme.colors.shadow,
                    radius: theme.metrics.shadowRadius,
                    x: theme.metrics.shadowXOffset,
                    y: theme.metrics.shadowYOffset)

                configuration.title
                    .font(style.typography.font)
            }
            .foregroundStyle(
                style.textColor.color(
                    isPressed: isPressed, isEnabled: isEnabled))
        }
    }
}

extension SnappThemingInteractiveColor {
    fileprivate func color(isPressed: Bool, isEnabled: Bool) -> Color {
        guard isEnabled else { return disabled }
        return isPressed ? pressed : normal
    }
}

extension ButtonStyle where Self == ActionButtonStyle {
    static var actionButton: Self {
        .init()
    }
}

#Preview {
    HStack {
        Button(action: {}) {
            Label {
                Text("Title")
            } icon: {
                Image(systemName: "xmark")
            }
        }
        .buttonStyle(.actionButton)
    }
}
