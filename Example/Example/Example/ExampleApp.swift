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
    var json: String = sampleJSON
    let configuration: SnappThemingParserConfiguration

    init() {
        guard let themeJSON = AvailableTheme.night.json else {
            fatalError("Couldn't find the theme JSON")
        }

        // Do this for turning the SVG processor on
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
