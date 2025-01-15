//
//  GradientsViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SwiftUI
import SnappTheming

struct NamedGradient: Identifiable {
    var id: String { name }

    let name: String
    let shape: AnyShapeStyle
}

struct GradientsViewer: View {
    let declarations: SnappThemingGradientDeclarations
    @State var selectedShape: NamedGradient?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                            selectedShape = .init(name: key, shape: AnyShapeStyle(declarations[dynamicMember: key]))
                        } label: {
                            GradientView(style: declarations[dynamicMember: key])
                        }
                    }
                }
            }
        }
        .navigationTitle("Gradients")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedShape) { shape in
            ZStack {
                Rectangle()
                    .fill(shape.shape)
                Text("\(shape.name)")
                    .padding()
                    .background(Color.black)
            }
        }
    }
}

#Preview {
    NavigationView {
        ColorsViewer(declarations: SnappThemingDeclaration.preview.colors)
    }
}
