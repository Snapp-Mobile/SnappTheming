//
//  ThemeViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming
import SwiftUI

enum ThemeDestination: String, Hashable, CaseIterable {
    #if !os(watchOS)
        case animations
    #endif
    case buttons, colors, fonts, gradients, images, metrics, shapes, typography, themeJSON
}

struct ThemeViewer: View {
    @Environment(Theme.self) private var theme
    @Binding var destination: ThemeDestination?

    var body: some View {
        List(selection: $destination) {
            Section {
                ForEach(ThemeDestination.allCases, id: \.self) { td in
                    NavigationLink(value: destination) {
                        if case td = .themeJSON {
                            Text("Theme JSON")
                        } else {
                            Text(td.rawValue.capitalized)
                        }
                    }
                }
            }
        }
        .navigationTitle("Tokens")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .listStyle(.sidebar)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    ThemeViewer(destination: .constant(.buttons))
        .environment(Theme(.default))
}
