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

    var body: some View {
        List {
            Section {
                ForEach(theme.typography.keys, id: \.self) { key in
                    let font: Font = theme.typography[dynamicMember: key]
                    Text(key)
                        .lineLimit(1)
                        .font(font)
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Typography")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TypographyViewer()
            .environment(Theme(.default))
    }
}
