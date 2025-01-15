//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import SwiftUI
import SnappTheming
// In case SVG support is needed
import SnappThemingSVGSupport

@main
struct ExampleApp: App {
    var json: String = sampleJSON
    let configuration: SnappThemingParserConfiguration

    init() {
        guard let themeJSON = AvailableTheme.night.json else {
            fatalError("Couldn't find the theme JSON")
        }

        SnappThemingImageProcessorsRegistry.shared.register(.svg)

        self.configuration = AvailableTheme.night.configuration

        self.json = themeJSON
    }

    var body: some Scene {
        WindowGroup {
            MainView(json: json, configuration: configuration)
        }
    }
}
