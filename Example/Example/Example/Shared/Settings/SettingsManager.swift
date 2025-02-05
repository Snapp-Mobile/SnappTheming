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
            defaults.currentThemeSource = theme.source
            updateThemeSource()
        }
    }

    var currentColorScheme: ColorScheme {
        didSet {
            updateThemeSource()
        }
    }

    private let defaults: UserDefaults = .standard

    private(set) var themeSource: Theme.Source

    init(currentColorScheme: ColorScheme) {
        let theme = ThemeSetting(source: defaults.currentThemeSource)
        self.theme = theme
        self.currentColorScheme = currentColorScheme
        self.themeSource = theme.source ?? currentColorScheme.themeSource
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

extension UserDefaults {
    private static let themeSourceFilenameKey = "theme_filename"

    fileprivate var currentThemeSource: Theme.Source? {
        get {
            string(forKey: Self.themeSourceFilenameKey).map(
                Theme.Source.init(rawValue:)) ?? nil
        }
        set {
            if let filename = newValue?.filename {
                set(newValue?.rawValue, forKey: Self.themeSourceFilenameKey)
            } else {
                removeObject(forKey: Self.themeSourceFilenameKey)
            }

        }
    }
}
