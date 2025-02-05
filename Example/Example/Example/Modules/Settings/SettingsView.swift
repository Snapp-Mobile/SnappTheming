//
//  SettingsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

import SwiftUI

enum SettingsDestination: Hashable {
    case tokens
    case json
}

struct SettingsView: View {
    @Environment(SettingsManager.self) private var manager
    @Environment(Theme.self) private var theme
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("General") {
                    @Bindable var manager = manager
                    Picker(selection: $manager.theme) {
                        ForEach(SettingsManager.ThemeSetting.allCases, id: \.description) { setting in
                            Text(setting.description)
                                .tag(setting)
                        }
                    } label: {
                        Text("Theme")
                    }
                    .pickerStyle(.menu)

                }

                Section("Theme") {
                    NavigationLink("Tokens", value: SettingsDestination.tokens)
                    NavigationLink("JSON", value: SettingsDestination.json)
                }
            }
            .background(theme.colors.surfacePrimary)
            .foregroundStyle(theme.colors.textColorPrimary)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SettingsDestination.self) {
                destination in
                switch destination {
                case .tokens:
                    ThemeViewer()
                case .json:
                    ThemeDeclarationJSONView()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(Theme(.default))
}
