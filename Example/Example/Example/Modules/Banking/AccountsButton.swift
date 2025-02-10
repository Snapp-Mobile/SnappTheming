//
//  AccountsButton.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 10.02.2025.
//

import SwiftUI

struct AccountsButton: View {
    let icon: Image
    let title: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(title)
            } icon: {
                icon.fitAndTemplated
            }
        }
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
