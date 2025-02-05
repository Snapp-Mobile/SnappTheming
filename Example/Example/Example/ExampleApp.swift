//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import SnappTheming
import SwiftUI

#if !os(visionOS)
    import SnappThemingSVGSupport
#endif

@main
struct ExampleApp: App {
    var json: String = sampleJSON
    let configuration: SnappThemingParserConfiguration

    init() {
        guard let themeJSON = AvailableTheme.night.json else {
            fatalError("Couldn't find the theme JSON")
        }

        #if !os(visionOS)
            // Do this for turning the SVG processor on
            SnappThemingImageProcessorsRegistry.shared.register(.svg)
        #endif

        self.configuration = AvailableTheme.night.configuration

        self.json = themeJSON
    }

    var body: some Scene {
        WindowGroup {
            MainView(json: json, configuration: configuration)
        }
    }
}
