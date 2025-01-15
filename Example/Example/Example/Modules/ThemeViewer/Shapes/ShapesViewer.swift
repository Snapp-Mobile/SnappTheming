//
//  ShapesViewer.swift
//  Example
//
//  Created by Ilian Konchev on 15.01.25.
//

import SnappTheming
import SwiftUI

struct ShapesViewer: View {
    let declarations: SnappThemingShapeDeclarations
    @State var states: [String: Bool] = [:]

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        declarations[dynamicMember: key]
                            .stroke(Color.blue)
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
        ShapesViewer(declarations: SnappThemingDeclaration.preview.shapes)
    }
}
