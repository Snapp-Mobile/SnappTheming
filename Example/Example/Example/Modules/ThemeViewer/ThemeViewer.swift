//
//  ThemeViewer.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming
import SwiftUI

enum ThemeDestination: String, Hashable, CaseIterable {
    case buttons, colors, fonts, images, metrics, shapes, typography, gradients, animations
}

struct ThemeViewer: View {
    var declaration: SnappThemingDeclaration

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
    }
}

#Preview {
    ThemeViewer(declaration: .preview)
}
