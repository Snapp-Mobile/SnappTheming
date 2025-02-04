//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import SnappTheming
import SnappThemingSVGSupport
import SwiftUI

@main
struct ExampleApp: App {
    init() {
        // Do this for turning the SVG processor on
        SnappThemingImageProcessorsRegistry.shared.register(.svg)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(Theme())
        }
    }
}
