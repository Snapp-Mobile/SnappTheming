//
//  ColorsViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming
import SwiftUI

struct ColorView: View {
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 24, height: 24)
            .foregroundStyle(color)
    }
}

struct ColorsViewer: View {
    let declarations: SnappThemingColorDeclarations
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    let color: Color = declarations[dynamicMember: key]
                    LabeledContent(
                        content: {
                            HStack {
                                ColorView(color: color)
                                    .environment(\.colorScheme, .light)
                                    .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                                ColorView(color: color)
                                    .environment(\.colorScheme, .dark)
                                    .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                            }
                        },
                        label: {
                            Text(key)
                                .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        }
                    )
                    .focusable(true)
                    .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Colors")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        ColorsViewer(declarations: SnappThemingDeclaration.preview.colors)
    }
}
