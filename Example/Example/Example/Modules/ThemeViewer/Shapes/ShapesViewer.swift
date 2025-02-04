//
//  ShapesViewer.swift
//  Example
//
//  Created by Ilian Konchev on 15.01.25.
//

import SnappTheming
import SwiftUI

struct ShapesViewer: View {
    @Environment(Theme.self) private var theme
    @State var states: [String: Bool] = [:]

    var body: some View {
        List {
            Section {
                ForEach(theme.shapes.keys, id: \.self) { key in
                    LabeledContent(key) {
                        theme.shapes[dynamicMember: key]
                            .stroke(Color.accentColor)
                            .frame(maxWidth: 80, minHeight: 30)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Shapes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ShapesViewer()
            .environment(Theme(.default))
    }
}
