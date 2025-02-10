//
//  SettingsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

import SwiftUI

enum SettingsDestination: Hashable {
    case tokens
}

struct SettingsView: View {
    @Environment(SettingsManager.self) private var manager
    @Environment(Theme.self) private var theme
    @State private var path = NavigationPath()
    @State var destination: ThemeDestination = .animations
    @State var settingsDestination: SettingsDestination = .tokens

    @ViewBuilder var navigation: some View {
        NavigationStack(path: $path) {
            List(selection: $settingsDestination) {
                #if !os(watchOS)
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
                #endif

                Section("Theme") {
                    NavigationLink("Tokens", value: SettingsDestination.tokens)
                }
            }
            .background(theme.colors.surfacePrimary)
            .foregroundStyle(theme.colors.textColorPrimary)
            .navigationTitle("Settings")
            #if os(iOS) || targetEnvironment(macCatalyst)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }

    var body: some View {
        NavigationSplitView(
            sidebar: {
                navigation
            },
            content: {
                switch settingsDestination {
                case .tokens:
                    ThemeViewer(destination: $destination)
                }
            },
            detail: {
                switch destination {
                case .buttons:
                    ButtonsViewer()
                case .colors:
                    ColorsViewer()
                case .fonts:
                    FontsViewer()
                case .images:
                    ImagesViewer()
                case .metrics:
                    MetricsViewer()
                case .typography:
                    TypographyViewer()
                case .gradients:
                    GradientsViewer()
                case .shapes:
                    ShapesViewer()
                #if !os(watchOS)
                    case .animations:
                        AnimationsViewer()
                    case .themeJSON:
                        ThemeDeclarationJSONView()
                #endif
                }
            }
        )
    }
}

#Preview {
    SettingsView(destination: .buttons)
        .themed()
        .environment(\.settingsStorage, .preview(.light))
}
