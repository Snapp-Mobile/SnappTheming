//
//  MainView.swift
//  Example
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import OSLog
import SnappTheming
import SwiftUI

enum Tab {
    case json, preview, tokens

    @ViewBuilder
    var label: some View {
        switch self {
        case .json:
            Label(title, systemImage: "curlybraces.square")
        case .preview:
            Label(title, systemImage: "theatermask.and.paintbrush")
        case .tokens:
            Label(title, systemImage: "swatchpalette.fill")
        }
    }

    var title: String {
        switch self {
        case .json:
            "JSON"
        case .preview:
            "Preview"
        case .tokens:
            "Tokens"
        }
    }
}

struct MainView: View {
    @State var declaration: SnappThemingDeclaration?
    @State var configuration: SnappThemingParserConfiguration?
    @State var encoded: String = ""
    @State var destinations = [ThemeDestination]()
    @State var selectedTab: Tab = .tokens
    @State var showsThemeSwitcher: Bool = false

    init(json: String, configuration: SnappThemingParserConfiguration) {
        do {
            let declaration = try SnappThemingParser.parse(from: json, using: configuration)
            _configuration = State(initialValue: configuration)
            _declaration = State(initialValue: declaration)
            let encodedOutput = try SnappThemingParser.encode(declaration, using: .init(encodeImages: true))
            _encoded = State(initialValue: String(data: encodedOutput, encoding: .utf8) ?? "Error")

            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL, themeName: configuration.themeName)
            fontManager.registerFonts(declaration.fontInformation)
        } catch let error {
            os_log(.error, "Error: %@", error.localizedDescription)
        }
    }

    private func changeTheme(to theme: AvailableTheme) {
        guard let json = theme.json, let oldConfiguration = configuration, let oldDeclaration = declaration else {
            return
        }
        let configuration = theme.configuration
        do {
            let deregisterFontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: oldConfiguration.themeCacheRootURL, themeName: oldConfiguration.themeName)
            deregisterFontManager.unregisterFonts(oldDeclaration.fontInformation)

            let declaration = try SnappThemingParser.parse(from: json, using: configuration)
            self.configuration = configuration
            self.declaration = declaration
            let encodedOutput = try SnappThemingParser.encode(declaration, using: .init(encodeImages: true))
            encoded = String(data: encodedOutput, encoding: .utf8) ?? "Error"

            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL, themeName: configuration.themeName)
            fontManager.registerFonts(declaration.fontInformation)
        } catch let error {
            os_log(.error, "Error: %@", error.localizedDescription)
        }
    }

    var body: some View {
        NavigationStack(path: $destinations) {
            VStack {
                if let declaration {
                    TabView(selection: $selectedTab) {
                        ThemeViewer(declaration: declaration)
                            .tabItem { Tab.tokens.label }
                            .tag(Tab.tokens)

                        ThemedView(declaration: declaration)
                            .tabItem { Tab.preview.label }
                            .tag(Tab.preview)

                        #if !os(tvOS) && !os(watchOS)
                            TextEditor(text: .constant(encoded))
                                .font(.system(size: 12.0, design: .monospaced))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                                .tabItem { Tab.json.label }
                                .tag(Tab.json)
                        #endif
                    }
                    #if os(tvOS)
                        .tabViewStyle(.sidebarAdaptable)
                    #endif
                    .navigationTitle(selectedTab.title)
                } else {
                    Text("Theme declaration is invalid.")
                }
            }
            .navigationDestination(for: ThemeDestination.self) { destination in
                if let declaration {
                    switch destination {
                    case .buttons:
                        ButtonsViewer(declarations: declaration.buttonStyles)
                    case .colors:
                        ColorsViewer(declarations: declaration.colors)
                    case .fonts:
                        FontsViewer(declarations: declaration.fonts)
                    case .images:
                        ImagesViewer(declarations: declaration.images)
                    case .metrics:
                        MetricsViewer(declarations: declaration.metrics)
                    case .typography:
                        TypographyViewer(declarations: declaration.typography)
                    case .gradients:
                        GradientsViewer(declarations: declaration.gradients)
                    case .shapes:
                        ShapesViewer(declarations: declaration.shapes)
                    case .animations:
                        #if !os(watchOS)
                            AnimationsViewer(declarations: declaration.animations)
                        #else
                            Text("Lottie animations are not supported on watchOS (for now)")
                        #endif
                    }
                } else {
                    EmptyView()
                }
            }
            .toolbar {
                #if os(watchOS) || os(tvOS)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                showsThemeSwitcher = true
                            },
                            label: {
                                Image(systemName: "slider.horizontal.3")
                                    .focusable()
                            }
                        )
                        .buttonStyle(.plain)
                    }
                #else
                    ToolbarItem(placement: .confirmationAction) {
                        Menu(
                            content: {
                                ForEach(AvailableTheme.allCases) { theme in
                                    Button {
                                        changeTheme(to: theme)
                                    } label: {
                                        Label(
                                            theme.description,
                                            systemImage: theme.configuration.themeName == configuration?.themeName ?? ""
                                                ? "paintbrush.fill" : "paintbrush"
                                        )
                                    }
                                }
                            },
                            label: {
                                Image(systemName: "slider.horizontal.3")
                            })
                    }
                #endif
            }
            .confirmationDialog("Pick a theme", isPresented: $showsThemeSwitcher) {
                ForEach(AvailableTheme.allCases) { theme in
                    Button(
                        action: {
                            changeTheme(to: theme)
                        },
                        label: {
                            Label(
                                theme.description,
                                systemImage: theme.configuration.themeName == configuration?.themeName ?? ""
                                    ? "paintbrush.fill" : "paintbrush"
                            )
                        })
                }
            }
        }
        .tint(declaration?.colors.textLink)
    }
}

#Preview("Light") {
    MainView(json: sampleJSON, configuration: .default)
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    MainView(json: sampleJSON, configuration: .default)
        .preferredColorScheme(.dark)
}
