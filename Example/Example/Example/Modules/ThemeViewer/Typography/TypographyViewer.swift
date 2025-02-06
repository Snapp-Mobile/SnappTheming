//
//  TypographyViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct TypographyViewer: View {
    @Environment(Theme.self) private var theme
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(theme.typography.keys, id: \.self) { key in
                    let font: Font = theme.typography[dynamicMember: key]
                    Text(key)
                        .lineLimit(1)
                        .font(font)
                        .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        .focusable(true)
                        .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Typography")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        TypographyViewer()
            .environment(Theme(.default))
    }
}
