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
    @State var theme: Theme

    private let settingsManager: SettingsManager
    private let storage: SettingsManager.Storage

    init() {
        storage = .userDefaults()

        settingsManager = SettingsManager(storage: .userDefaults(), fallbackColorSchema: .dark)
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
