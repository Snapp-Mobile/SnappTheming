//
//  TypographyViewer.swift
//  Example
//
//  Created by Ilian Konchev on 4.12.24.
//

import SnappTheming
import SwiftUI

struct TypographyViewer: View {
    let declarations: SnappThemingTypographyDeclarations

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    let font: Font = declarations[dynamicMember: key]
                    Text(key)
                        .lineLimit(1)
                        .font(font)
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Typography")
        #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        TypographyViewer(declarations: SnappThemingDeclaration.preview.typography)
    }
}
