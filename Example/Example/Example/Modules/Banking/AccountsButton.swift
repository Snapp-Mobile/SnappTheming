//
//  AccountsButton.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 10.02.2025.
//

import SwiftUI

struct AccountsButton: View {
    @Environment(Theme.self) private var theme
    @FocusState private var isFocused: Bool
    let icon: Image
    let title: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(title)
                    .bold(isFocused)
                    .foregroundStyle(isFocused ? theme.colors.primary : theme.colors.textColorPrimary)
            } icon: {
                icon.fitAndTemplated
                    .foregroundStyle(isFocused ? theme.colors.primary : theme.colors.textColorPrimary)
            }
        }
        .buttonStyle(.actionButton)
        .focusable()
        .focused($isFocused, equals: true)
        #if os(macOS)
            .focusEffectDisabled()
        #endif
    }

    init(icon: Image, title: String, action: @escaping () -> Void = {}) {
        self.icon = icon
        self.title = title
        self.action = action
    }
}

extension Image {
    var fitAndTemplated: some View {
        self
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
    }
}
