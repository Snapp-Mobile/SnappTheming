//
//  Themed.swift
//  Example
//
//  Created by Volodymyr Voiko on 05.02.2025.
//

import SwiftUI

private struct ThemedModifier: ViewModifier {
    @Environment(\.colorScheme) var appColorScheme
    let settingsManager: SettingsManager
    @Binding var theme: Theme

    func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, settingsManager.themeSource.colorScheme)
            #if os(tvOS) || os(macOS)
                .colorScheme(settingsManager.themeSource.colorScheme)
                .preferredColorScheme(settingsManager.themeSource.colorScheme)
            #endif
            .onChange(of: settingsManager.themeSource, initial: true) { _, newThemeSource in
                theme.source = newThemeSource
                settingsManager.currentColorScheme = newThemeSource.colorScheme
            }
            .onChange(of: appColorScheme, initial: true) { _, newColorScheme in
                settingsManager.currentColorScheme = newColorScheme
            }
    }
}

extension View {
    func themed(with settingsManager: SettingsManager, theme: Binding<Theme>) -> some View {
        modifier(ThemedModifier(settingsManager: settingsManager, theme: theme))
    }
}
