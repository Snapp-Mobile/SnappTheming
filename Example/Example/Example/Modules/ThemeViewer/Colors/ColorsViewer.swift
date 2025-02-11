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
    @FocusState private var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(theme.colors.keys, id: \.self) { key in
                    let color: Color = theme.colors[dynamicMember: key]
                    LabeledContent {
                        HStack {
                            #if !os(watchOS)
                                ColorView(color: color)
                                    .environment(\.colorScheme, .light)
                                    .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                            #endif
                            ColorView(color: color)
                                .environment(\.colorScheme, .dark)
                                .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                        }
                    } label: {
                        Text(key)
                            .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                    }
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
        ColorsViewer()
            .environment(Theme(.default))
    }
}
