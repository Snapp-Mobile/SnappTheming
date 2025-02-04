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
    @Environment(Theme.self) private var theme

    var body: some View {
        List {
            Section {
                ForEach(theme.colors.keys, id: \.self) { key in
                    let color: Color = theme.colors[dynamicMember: key]
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
        ColorsViewer()
            .environment(Theme(.default))
    }
}
