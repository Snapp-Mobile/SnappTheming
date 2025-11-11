//
//  SettingsManager.swift
//  Example
//
//  Created by Volodymyr Voiko on 05.02.2025.
//

import Foundation
import SwiftUI

@Observable
final class SettingsManager {
    struct Storage {
        let getCurrentThemeSource: () -> Theme.Source?
        let setCurrentThemeSource: (Theme.Source?) -> Void

        init(
            getCurrentThemeSource: @escaping () -> Theme.Source?,
            setCurrentThemeSource: @escaping (Theme.Source?) -> Void
        ) {
            self.getCurrentThemeSource = getCurrentThemeSource
            self.setCurrentThemeSource = setCurrentThemeSource
        }
    }

    enum ThemeSetting: Hashable, CustomStringConvertible, CaseIterable {
        static let allCases: [ThemeSetting] = [.system] + Theme.Source.allCases.map(Self.specific(_:))

        case system
        case specific(Theme.Source)

        var description: String {
            guard case .specific(let source) = self else {
                return "System"
            }
            return source.description
        }

        var source: Theme.Source? {
            guard case .specific(let source) = self else {
                return nil
            }
            return source
        }

        init(source: Theme.Source?) {
            self = source.map(Self.specific(_:)) ?? .system
        }
    }

    var theme: ThemeSetting {
        didSet {
            storage.setCurrentThemeSource(theme.source)
            updateThemeSource()
        }
    }

    var currentColorScheme: ColorScheme {
        didSet {
            updateThemeSource()
        }
    }

    private let storage: Storage

    private(set) var themeSource: Theme.Source

    init(storage: Storage, fallbackColorSchema: ColorScheme = .light) {
        let theme = ThemeSetting(source: storage.getCurrentThemeSource())
        let colorSchema = theme.source?.colorScheme ?? fallbackColorSchema
        self.storage = storage
        self.theme = theme
        self.currentColorScheme = colorSchema
        self.themeSource = theme.source ?? colorSchema.themeSource
    }

    private func updateThemeSource() {
        themeSource = theme.source ?? currentColorScheme.themeSource
    }
}

extension ColorScheme {
    var themeSource: Theme.Source {
        switch self {
        case .light: return .light
        case .dark: fallthrough
        @unknown default: return .dark
        }
    }
}

extension SettingsManager.Storage {
    private static let themeSourceFilenameKey = "theme_filename"

    static func userDefaults(_ defaults: UserDefaults = .standard) -> Self {
        Self {
            defaults.string(forKey: Self.themeSourceFilenameKey)
                .map(Theme.Source.init(rawValue:)) ?? nil
        } setCurrentThemeSource: { newValue in
            if let filename = newValue?.filename {
                defaults.set(filename, forKey: Self.themeSourceFilenameKey)
            } else {
                defaults.removeObject(forKey: Self.themeSourceFilenameKey)
            }
        }
    }

    static func preview(_ initialThemeSource: Theme.Source? = nil) -> Self {
        var currentThemeSource: Theme.Source? = initialThemeSource
        return Self {
            currentThemeSource
        } setCurrentThemeSource: {
            currentThemeSource = $0
        }
    }
}

extension EnvironmentValues {
    @Entry var settingsStorage: SettingsManager.Storage = .userDefaults()
}
