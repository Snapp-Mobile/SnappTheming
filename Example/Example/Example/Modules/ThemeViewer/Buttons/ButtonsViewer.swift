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
    let declarations: SnappThemingButtonStyleDeclarations
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(
                        content: {
                            Button {
                            } label: {
                                Image(systemName: "gearshape")
                            }
                            .buttonStyle(declarations[dynamicMember: key])
                            .frame(
                                minWidth: (key == "primaryCritical" || key == "primaryBrand") ? 128 : 64,
                                minHeight: 64
                            )
                            .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                        },
                        label: {
                            Text(key)
                                .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        }
                    )
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
        ButtonsViewer(declarations: SnappThemingDeclaration.preview.buttonStyles)
    }
}
