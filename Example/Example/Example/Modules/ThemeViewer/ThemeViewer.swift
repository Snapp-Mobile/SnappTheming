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
    case buttons, colors, fonts, gradients, images, metrics, shapes, typography
    #if !os(tvOS) && !os(watchOS)
        case themeJSON = "Theme JSON"
    #endif
}

struct ThemeViewer: View {
    @Environment(Theme.self) private var theme
    @Binding var selectedDestination: ThemeDestination?

    var body: some View {
        List(ThemeDestination.allCases, id: \.self, selection: $selectedDestination) { destination in
            NavigationLink(value: destination) {
                Text(destination.rawValue.capitalized)
                    .foregroundStyle(theme.colors.textColorPrimary)
            }
        }
        .navigationTitle("Tokens")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .listStyle(.sidebar)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    init(with selectedDestination: Binding<ThemeDestination?>) {
        self._selectedDestination = selectedDestination
    }
}

#Preview {
    ThemeViewer(with: .constant(.buttons))
        .environment(Theme(.default))
}
