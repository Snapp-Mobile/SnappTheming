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
    case buttons, colors, fonts, images, metrics, shapes, typography, gradients
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
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
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
            #if !os(watchOS)
                case .animations:
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
