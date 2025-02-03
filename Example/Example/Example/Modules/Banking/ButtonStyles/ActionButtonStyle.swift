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
    private let declaration: SnappThemingDeclaration

    init(declaration: SnappThemingDeclaration) {
        self.declaration = declaration
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label.labelStyle(
            ActionButtonLabelStyle(
                declaration: declaration, isPressed: configuration.isPressed))
    }

    private struct ActionButtonLabelStyle: LabelStyle {
        private let declaration: SnappThemingDeclaration

        @Environment(\.isEnabled)
        private var isEnabled
        private let isPressed: Bool

        init(declaration: SnappThemingDeclaration, isPressed: Bool) {
            self.declaration = declaration
            self.isPressed = isPressed
        }

        func makeBody(configuration: Configuration) -> some View {
            let style: SnappThemingButtonStyleResolver = declaration
                .buttonStyles.action
            let iconSize = declaration.metrics.iconSize
            let buttonSize = declaration.metrics.buttonSize
            VStack(spacing: declaration.metrics.small) {
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
                    color: declaration.colors.shadow,
                    radius: declaration.metrics.shadowRadius,
                    x: declaration.metrics.shadowXOffset,
                    y: declaration.metrics.shadowYOffset)

                configuration.title
                    .font(style.typography.font)
                    .foregroundStyle(
                        style.textColor.color(
                            isPressed: isPressed, isEnabled: isEnabled))
            }
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
    static func actionButton(_ declaration: SnappThemingDeclaration) -> Self {
        .init(declaration: declaration)
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
        .buttonStyle(.actionButton(.bankingLight))
    }
}
