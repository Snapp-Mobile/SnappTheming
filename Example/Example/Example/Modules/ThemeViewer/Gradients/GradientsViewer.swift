//
//  GradientsViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming
import SwiftUI

struct NamedGradient: Identifiable {
    var id: String { name }

    let name: String
    let shape: AnyShapeStyle
}

struct GradientsViewer: View {
    let declarations: SnappThemingGradientDeclarations
    @State var selectedShape: NamedGradient?
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(
                        content: {
                            Button {
                                selectedShape = .init(name: key, shape: AnyShapeStyle(declarations[dynamicMember: key]))
                            } label: {
                                GradientView(style: declarations[dynamicMember: key])
                            }
                            .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                        },
                        label: {
                            Text(key)
                                .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                        }
                    )
                    .focusable(true)
                    .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Gradients")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
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
