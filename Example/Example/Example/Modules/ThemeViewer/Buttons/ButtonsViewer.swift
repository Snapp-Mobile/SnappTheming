//
//  ButtonsViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SnappThemingSwiftUIHelpers
import SwiftUI

struct ButtonsViewer: View {
    @Environment(Theme.self) private var theme
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(theme.buttonStyles.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .buttonStyle(theme.buttonStyles[dynamicMember: key])
                        .frame(
                            minWidth: (key == "primaryCritical" || key == "primaryBrand") ? 128 : 64, minHeight: 64)
                    }
                    .focusable(true)
                    .focused($focusedKey, equals: key)
                }
            } footer: {
                Text("Tap on a button to toggle between its normal and selected state")
            }
        }
        .navigationTitle("Button Styles")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        ButtonsViewer()
            .environment(Theme(.default))
    }
}
