//
//  Themed.swift
//  Example
//
//  Created by Volodymyr Voiko on 05.02.2025.
//

import SwiftUI

private struct ThemedModifier: ViewModifier {
    @Environment(\.colorScheme) var colorSchema
    @Environment(\.settingsStorage) var storage

    func body(content: Content) -> some View {
        let settingsManager = SettingsManager(storage: storage, fallbackColorSchema: colorSchema)
        let theme = Theme(settingsManager.themeSource)

        content
            .colorScheme(settingsManager.themeSource.colorScheme)
            .environment(settingsManager)
            .environment(theme)
            .onChange(of: settingsManager.themeSource, initial: true) { (_, newThemeSource) in
                theme.source = newThemeSource
            }
            .onChange(of: colorSchema, initial: true) { (_, newColorSchema) in
                settingsManager.currentColorScheme = newColorSchema
            }
    }
}

extension View {
    func themed() -> some View {
        modifier(ThemedModifier())
    }
}
