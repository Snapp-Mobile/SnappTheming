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
    @Environment(\.dismiss) var dismiss
    @Environment(Theme.self) private var theme
    @State var selectedShape: NamedGradient?
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(theme.gradients.keys, id: \.self) { key in
                    LabeledContent {
                        Button {
                            selectedShape = .init(name: key, shape: AnyShapeStyle(theme.gradients[dynamicMember: key]))
                        } label: {
                            GradientView(style: theme.gradients[dynamicMember: key])
                        }
                        .scaleEffect(focusedKey == key ? 1.2 : 1.0)
                    } label: {
                        Text(key)
                            .foregroundStyle(focusedKey == key ? Color.accentColor : .primary)
                    }
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
            NavigationStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(shape.shape)
                    Text("\(shape.name)")
                        #if !os(watchOS)
                            .padding()
                        #endif
                        .background(theme.colors.textColorPrimaryInverted)
                        .foregroundColor(theme.colors.textColorPrimary)
                }
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }
                }
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
