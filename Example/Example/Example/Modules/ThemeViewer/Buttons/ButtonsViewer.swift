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

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .buttonStyle(declarations[dynamicMember: key])
                        .frame(minWidth: (key == "primaryCritical" || key == "primaryBrand") ? 128 : 64, minHeight: 64)
                    }
                }
            } footer: {
                Text("Tap on a button to toggle between its normal and selected state")
            }
        }
        .navigationTitle("Button Styles")
        #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        ButtonsViewer(declarations: SnappThemingDeclaration.preview.buttonStyles)
    }
}
