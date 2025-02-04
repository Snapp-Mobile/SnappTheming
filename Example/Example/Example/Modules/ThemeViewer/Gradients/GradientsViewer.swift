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
    @Environment(Theme.self) private var theme
    @State var selectedShape: NamedGradient?

    var body: some View {
        List {
            Section {
                ForEach(theme.gradients.keys, id: \.self) { key in
                    LabeledContent(key) {
                        Button {
                            selectedShape = .init(name: key, shape: AnyShapeStyle(theme.gradients[dynamicMember: key]))
                        } label: {
                            GradientView(style: theme.gradients[dynamicMember: key])
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
        ColorsViewer()
            .environment(Theme(.default))
    }
}
