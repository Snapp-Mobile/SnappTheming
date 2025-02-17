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
    @State private var showsActionSheet = false
    @State var destination: ThemeDestination?
    @State var settingsDestination: SettingsDestination?
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
        .navigationTitle("Settings")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .background(theme.colors.surfacePrimary)
            .foregroundStyle(theme.colors.textColorPrimary)
            .navigationBarTitleDisplayMode(.inline)
        #endif

    }

    @ViewBuilder
    func detailsView(for destination: ThemeDestination?) -> some View {
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
        #endif
        #if !os(tvOS) && !os(watchOS)
            case .themeJSON:
                ThemeDeclarationJSONView()
        #endif
        default:
            Text("Select a theme option")
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
                        Button {
                            showsActionSheet = true
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                        .foregroundStyle(theme.colors.textColorPrimary)
                        .confirmationDialog("Pick a theme", isPresented: $showsActionSheet, titleVisibility: .visible) {
                            @Bindable var manager = manager
                            ForEach(SettingsManager.ThemeSetting.allCases, id: \.description) { setting in
                                Button {
                                    manager.theme = setting
                                } label: {
                                    Text(setting.description)
                                }
                            }
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
                        ThemeViewer(with: $destination)
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
    let manager: SettingsManager = .init(storage: .preview(.light), fallbackColorSchema: .light)
    SettingsView(destination: .buttons)
        .themed(with: manager, theme: .constant(.init(manager.themeSource)))
}
