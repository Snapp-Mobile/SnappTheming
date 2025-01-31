//
//  ActionButtonStyle.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation
import SnappTheming
import SwiftUI

// TODO: Create button style in theme

struct ActionButtonStyle: ButtonStyle {
    private let declaration: SnappThemingDeclaration

    init(declaration: SnappThemingDeclaration) {
        self.declaration = declaration
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label.labelStyle(.actionButton(declaration))
    }
}

struct ActionButtonLabelStyle: LabelStyle {
    private let declaration: SnappThemingDeclaration

    init(declaration: SnappThemingDeclaration) {
        self.declaration = declaration
    }

    func makeBody(configuration: Configuration) -> some View {
        let iconSize = declaration.metrics.iconSize
        let buttonSize = declaration.metrics.buttonSize
        VStack(spacing: declaration.metrics.small) {
            ZStack {
                configuration.icon
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: buttonSize, height: buttonSize)
            .background(Circle().fill(declaration.colors.surfacePrimary))
            .shadow(color: .gray.opacity(0.1), radius: 12, x: 0, y: 4)

            configuration.title
                .font(declaration.typography.body)
                .foregroundStyle(declaration.colors.textColorPrimary)
        }
    }
}

extension LabelStyle where Self == ActionButtonLabelStyle {
    static func actionButton(_ declaration: SnappThemingDeclaration) -> Self {
        .init(declaration: declaration)
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
