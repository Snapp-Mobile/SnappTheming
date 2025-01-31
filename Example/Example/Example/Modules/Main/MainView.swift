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
    case json, preview, tokens, banking

    @ViewBuilder
    var label: some View {
        switch self {
        case .json:
            Label(title, systemImage: "curlybraces.square")
        case .preview:
            Label(title, systemImage: "theatermask.and.paintbrush")
        case .tokens:
            Label(title, systemImage: "swatchpalette.fill")
        case .banking:
            Label(title, systemImage: "wallet.bifold.fill")
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
        case .banking:
            "Banking"
        }
    }
}

struct MainView: View {
    @State var declaration: SnappThemingDeclaration?
    @State var configuration: SnappThemingParserConfiguration?
    @State var encoded: String = ""
    @State var destinations = [ThemeDestination]()
    @State var selectedTab: Tab = .tokens

    init(json: String, configuration: SnappThemingParserConfiguration) {
        do {
            let declaration = try SnappThemingParser.parse(
                from: json, using: configuration)
            _configuration = State(initialValue: configuration)
            _declaration = State(initialValue: declaration)
            let encodedOutput = try SnappThemingParser.encode(
                declaration, using: .init(encodeImages: true))
            _encoded = State(
                initialValue: String(data: encodedOutput, encoding: .utf8)
                    ?? "Error")

            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL,
                themeName: configuration.themeName)
            fontManager.registerFonts(declaration.fontInformation)
        } catch let error {
            os_log(.error, "Error: %@", error.localizedDescription)
        }
    }

    private func changeTheme(to theme: AvailableTheme) {
        guard let json = theme.json, let oldConfiguration = configuration,
            let oldDeclaration = declaration
        else {
            return
        }
        let configuration = theme.configuration
        do {
            let deregisterFontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: oldConfiguration.themeCacheRootURL,
                themeName: oldConfiguration.themeName)
            deregisterFontManager.unregisterFonts(
                oldDeclaration.fontInformation)

            let declaration = try SnappThemingParser.parse(
                from: json, using: configuration)
            self.configuration = configuration
            self.declaration = declaration
            let encodedOutput = try SnappThemingParser.encode(
                declaration, using: .init(encodeImages: true))
            encoded = String(data: encodedOutput, encoding: .utf8) ?? "Error"

            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL,
                themeName: configuration.themeName)
            fontManager.registerFonts(declaration.fontInformation)
        } catch let error {
            os_log(.error, "Error: %@", error.localizedDescription)
        }
    }

    var body: some View {
        VStack {
            if let declaration {
                TabView(selection: $selectedTab) {
                    NavigationStack(path: $destinations) {
                        themeToolbar {
                            ThemeViewer(declaration: declaration)
                        }
                        .navigationDestination(for: ThemeDestination.self) { destination in
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
                                AnimationsViewer(declarations: declaration.animations)
                            }
                        }
                    }
                    .tabItem { Tab.tokens.label }
                    .tag(Tab.tokens)

                    themeToolbar {
                        ThemedView(declaration: declaration)
                    }
                    .tabItem { Tab.preview.label }
                    .tag(Tab.preview)

                    themeToolbar {
                        TextEditor(text: .constant(encoded))
                            .font(.system(size: 12.0, design: .monospaced))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    }
                    .tabItem { Tab.json.label }
                    .tag(Tab.json)

                    NavigationStack {
                        // TODO: Replace with proper theme
                        AccountsView(declaration: .bankingLight)
                    }
                    .tabItem { Tab.banking.label }
                    .tag(Tab.banking)
                }
                .navigationTitle(selectedTab.title)
            } else {
                Text("Theme declaration is invalid.")
            }
        }
        .tint(declaration?.colors.textLink)
    }

    private func themeToolbar(@ViewBuilder _ content: () -> some View)
        -> some View
    {
        content().toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Menu(
                    content: {
                        ForEach(AvailableTheme.allCases) { theme in
                            Button {
                                changeTheme(to: theme)
                            } label: {
                                Label(
                                    theme.description,
                                    systemImage: theme.configuration.themeName
                                        == configuration?.themeName ?? ""
                                        ? "paintbrush.fill" : "paintbrush"
                                )
                            }
                        }
                    }, label: { Image(systemName: "slider.horizontal.3") })
            }
        }
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
