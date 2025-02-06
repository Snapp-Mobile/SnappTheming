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
    @FocusState var focusedKey: String?
    @State var states: [String: Bool] = [:]

    var body: some View {
        List {
            Section {
                ForEach(theme.shapes.keys, id: \.self) { key in
                    LabeledContent {
                        theme.shapes[dynamicMember: key]
                            .stroke(
                                focusedKey == key ? Color.accentColor : .primary
                            )
                            .frame(maxWidth: 80, minHeight: 30)
                            .padding(.vertical, 4)
                    } label: {
                        Text(key)
                            .foregroundStyle(
                                focusedKey == key ? Color.accentColor : .primary
                            )
                    }
                    .focusable(true)
                    .focused($focusedKey, equals: key)
                }
            }
        }
        .navigationTitle("Shapes")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationView {
        ShapesViewer()
            .environment(Theme(.default))
    }
}
