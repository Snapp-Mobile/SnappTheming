//
//  ColorsViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SwiftUI
import SnappTheming

struct ShapeStyleView<Shape: ShapeStyle>: View {
    let shape: Shape

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 120, height: 48)
            .foregroundStyle(shape)
    }
}

struct NamedShapeStyle: Identifiable {
    var id: String { name }

    let name: String
    let shape: AnyShapeStyle
}

struct ShapeStylesView: View {
    let declarations: SnappThemingGradientDeclarations
    @State var selectedShape: NamedShapeStyle?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                            selectedShape = .init(name: key, shape: AnyShapeStyle(declarations[dynamicMember: key]))
                        } label: {
                            ShapeStyleView(shape: declarations[dynamicMember: key])
                        }
                    }
                }
            }
        }
        .navigationTitle("Shape Styles")
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
