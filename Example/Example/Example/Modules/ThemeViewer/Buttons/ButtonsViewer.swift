//
//  ButtonsViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct ButtonsViewer: View {
    let declarations: SnappThemingButtonStyleDeclarations
    @State var states: [String: Bool] = [:]

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                            let value = states[key] ?? false
                            states[key] = !value
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .buttonStyle(AppButtonStyle(selected: states[key] ?? false, style: declarations[dynamicMember: key], width: (key == "primaryCritical" || key == "primaryBrand") ? 128 : 64))
                    }
                }
            } footer: {
                Text("Tap on a button to toggle between its normal and selected state")
            }
        }
        .navigationTitle("Button Styles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ButtonsViewer(declarations: SnappThemingDeclaration.preview.buttonStyles)
    }
}
