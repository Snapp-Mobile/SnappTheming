//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import SwiftUI
import SnappTheming

@main
struct ExampleApp: App {
    var json: String = sampleJSON
    var configuration: SnappThemingParserConfiguration = .default

    init() {
        guard let themeJSON = AvailableTheme.night.json else {
            fatalError("Couldn't find the theme JSON")
        }
        self.configuration = AvailableTheme.night.configuration
        self.json = themeJSON
    }

    var body: some Scene {
        WindowGroup {
            MainView(json: json, configuration: configuration)
        }
    }
}
