//
//  ExampleWatchOSAppApp.swift
//  ExampleWatchOSApp Watch App
//
//  Created by Ilian Konchev on 5.02.25.
//

import SnappTheming
import SwiftUI

@main
struct ExampleWatchOSApp_Watch_AppApp: App {
    var json: String = sampleJSON
    let configuration: SnappThemingParserConfiguration

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
