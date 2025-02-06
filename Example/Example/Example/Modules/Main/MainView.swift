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

enum Tab: String, Hashable, Identifiable, CaseIterable {
    case accounts
    case settings

    var title: String {
        switch self {
        case .accounts: "Accounts"
        case .settings: "Settings"
        }
    }
    var imageName: String {
        switch self {
        case .accounts: "wallet"
        case .settings: "settings"
        }
    }

    var id: String { rawValue }
}

struct MainView: View {
    @State var destinations = [ThemeDestination]()
    @State var selectedTab: Tab = .accounts
    @State var showsThemeSwitcher: Bool = false

    @Environment(Theme.self) private var theme

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ForEach(Tab.allCases) { tab in
                    tabContent(tab)
                        #if !os(watchOS)
                            .tabItem {
                                Label {
                                    Text(tab.title)
                                } icon: {
                                    theme.images[dynamicMember: tab.imageName]
                                }
                            }
                        #endif
                        .tag(tab)
                }
            }
            #if os(tvOS)
                .tabViewStyle(.sidebarAdaptable)
            #endif
            .tint(theme.colors.primary)
            .colorScheme(theme.source.colorScheme)
        }
    }

    @ViewBuilder
    private func tabContent(_ tab: Tab) -> some View {
        switch tab {
        case .accounts:
            AccountsView()
        case .settings:
            SettingsView()
        }
    }
}

#Preview("Light") {
    MainView()
        .themed()
        .preferredColorScheme(.light)
}

#Preview("Dark") {
    MainView()
        .themed()
        .preferredColorScheme(.dark)
}
