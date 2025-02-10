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
    @State var destination: ThemeDestination? = .animations
    @State var settingsDestination: SettingsDestination? = .tokens
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var preferredCompactColumn: NavigationSplitViewColumn = .sidebar

    @ViewBuilder var navigation: some View {
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

    @ViewBuilder
    func detailsView(for destination: ThemeDestination) -> some View {
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
        #else
            #if !os(tvOS)
                case .themeJSON:
                    ThemeDeclarationJSONView()
            #endif
        #endif
        }
    }

    #if os(tvOS)
        var body: some View {
            NavigationStack(path: $path) {
                List {
                    ForEach(ThemeDestination.allCases, id: \.self) { td in
                        NavigationLink(value: td) {
                            Text(td.rawValue.capitalized)
                        }
                    }
                }
                .navigationDestination(for: ThemeDestination.self) { td in
                    detailsView(for: td)
                }
                .navigationBarBackButtonHidden(false)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            ForEach(SettingsManager.ThemeSetting.allCases, id: \.description) { setting in
                                Button {
                                    manager.theme = setting
                                } label: {
                                    Text(setting.description)
                                }
                            }
                        } label: {
                            Label {
                                Text("Theme: \(manager.theme.description)")
                            } icon: {
                                Image(systemName: "slider.horizontal.3")
                            }
                            .foregroundStyle(theme.colors.textColorPrimary)
                        }
                    }
                }
            }

        }
    #else
        var body: some View {
            NavigationSplitView(
                columnVisibility: $columnVisibility,
                preferredCompactColumn: $preferredCompactColumn,
                sidebar: {
                    navigation
                },
                content: {
                    switch settingsDestination {
                    case .tokens:
                        ThemeViewer(destination: $destination)
                    case .none:
                        EmptyView()
                    }
                },
                detail: {
                    detailsView(for: destination)
                }
            )
        }
    #endif
}

#Preview {
    SettingsView(destination: .buttons)
        .themed()
        .environment(\.settingsStorage, .preview(.light))
}
