//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import OSLog
import SnappTheming
import SwiftUI

#if !os(visionOS)
    import SnappThemingSVGSupport
#endif

@main
struct ExampleApp: App {
    @State var theme: Theme

    private let settingsManager: SettingsManager
    private let storage: SettingsManager.Storage

    init() {
        #if !os(visionOS)
            // Do this for turning the SVG processor on
            SnappThemingImageProcessorsRegistry.shared.register(.svg)
        #endif

        storage = .userDefaults()

        settingsManager = SettingsManager(storage: .userDefaults(), fallbackColorSchema: .light)
        theme = Theme(settingsManager.themeSource)
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .themed(with: settingsManager, theme: $theme)
                .environment(settingsManager)
                .environment(theme)
        }
    }
}
