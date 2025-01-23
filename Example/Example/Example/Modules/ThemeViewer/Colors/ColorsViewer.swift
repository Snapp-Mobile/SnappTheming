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

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    let color: Color = declarations[dynamicMember: key]
                    LabeledContent(key) {
                        HStack {
                            ColorView(color: color)
                                .environment(\.colorScheme, .light)
                            ColorView(color: color)
                                .environment(\.colorScheme, .dark)
                        }
                    }
                }
            }
        }
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ColorsViewer(declarations: SnappThemingDeclaration.preview.colors)
    }
}
