//
//  ThemeViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming
import SwiftUI

enum ThemeDestination: String, Hashable, CaseIterable {
    case animations, buttons, colors, fonts, images, metrics, shapes, typography, gradients
}

struct ThemeViewer: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        List {
            Section {
                ForEach(ThemeDestination.allCases, id: \.self) { destination in
                    NavigationLink(value: destination) {
                        Text(destination.rawValue.capitalized)
                    }
                }
            }
        }
        .navigationTitle("Tokens")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: ThemeDestination.self) { destination in
            switch destination {
            case .buttons:
                ButtonsViewer()
            case .colors:
                ColorsViewer()
            case .fonts:
                FontsViewer()
            case .images:
                ImagesViewer()
            case .metrics:
                MetricsViewer()
            case .typography:
                TypographyViewer()
            case .gradients:
                GradientsViewer()
            case .shapes:
                ShapesViewer()
            case .animations:
                #if !os(watchOS)
                    AnimationsViewer()
                #endif
            }
        }
    }
}

#Preview {
    ThemeViewer()
        .environment(Theme(.default))
}
