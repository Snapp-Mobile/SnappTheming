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
    @Environment(\.colorScheme) var colorSchema
    @State var scheme: ColorScheme = .light
    var settingsManager: SettingsManager
    @State var theme: Theme

    var storage: SettingsManager.Storage

    init() {
        #if !os(visionOS)
            // Do this for turning the SVG processor on
            SnappThemingImageProcessorsRegistry.shared.register(.svg)
        #endif

        storage = .userDefaults()

        settingsManager = SettingsManager(storage: .userDefaults(), fallbackColorSchema: .light)
        theme = Theme(settingsManager.themeSource)
        scheme = settingsManager.themeSource.colorScheme
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(scheme)
                .environment(\.colorScheme, settingsManager.themeSource.colorScheme)
                .colorScheme(settingsManager.themeSource.colorScheme)
                .environment(theme)
                .environment(settingsManager)
                .onChange(of: settingsManager.themeSource, initial: true) { (_, newThemeSource) in
                    //                    if theme.source != newThemeSource {
                    //                        theme.source = newThemeSource
                    //                    }
                    theme = Theme(newThemeSource)
                    scheme = newThemeSource.colorScheme
                }
                .onChange(of: colorSchema, initial: true) { (_, newColorSchema) in
                    scheme = newColorSchema
                }
        }
    }
}
