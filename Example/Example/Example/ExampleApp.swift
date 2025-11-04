//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import OSLog
import SnappTheming
import SwiftUI

@main
struct ExampleApp: App {
    @State var theme: Theme

    private let settingsManager: SettingsManager
    private let storage: SettingsManager.Storage

    init() {
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
