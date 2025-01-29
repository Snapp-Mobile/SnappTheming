//
//  ActionButtonStyle.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation
import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.labelStyle(.actionButton)
    }
}

struct ActionButtonLabelStyle: LabelStyle {
    private let iconSize: CGFloat = 24
    private let buttonSize: CGFloat = 64

    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 8) {
            ZStack {
                configuration.icon
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(width: buttonSize, height: buttonSize)
            .background(Circle().fill(Color.white))
            .shadow(color: .gray.opacity(0.1), radius: 12, x: 0, y: 4)

            configuration.title
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

extension LabelStyle where Self == ActionButtonLabelStyle {
    static var actionButton: Self { .init() }
}

extension ButtonStyle where Self == ActionButtonStyle {
    static var actionButton: Self { .init() }
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
