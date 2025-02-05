//
//  FontsViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct FontsViewer: View {
    let declarations: SnappThemingFontDeclarations
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    let resolver: SnappThemingFontResolver = declarations[dynamicMember: key]
                    Text(key)
                        .font(resolver.font(size: 14.0))
                        .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        .focusable(true)
                        .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Fonts")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        FontsViewer(declarations: SnappThemingDeclaration.preview.fonts)
    }
}
