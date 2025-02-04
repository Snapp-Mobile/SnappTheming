//
//  FontsViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct FontsViewer: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        List {
            Section {
                ForEach(theme.fonts.keys, id: \.self) { key in
                    let resolver: SnappThemingFontResolver = theme.fonts[dynamicMember: key]
                    Text(key)
                        .font(resolver.font(size: 14.0))
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Fonts")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        FontsViewer()
            .environment(Theme(.default))
    }
}
