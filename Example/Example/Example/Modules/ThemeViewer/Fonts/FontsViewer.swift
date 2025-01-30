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

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    let resolver: SnappThemingFontResolver = declarations[dynamicMember: key]
                    Text(key)
                        .font(resolver.font(size: 14.0))
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Fonts")
        #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        FontsViewer(declarations: SnappThemingDeclaration.preview.fonts)
    }
}
