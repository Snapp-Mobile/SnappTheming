//
//  AccountsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct AccountsView: View {
    @Environment(Theme.self) private var theme
    @Environment(SettingsManager.self) private var manager

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: theme.metrics.xlarge) {
                    CreditCardView()

                    // TODO: Fix for watchOS
                    // Note: ActionsContainer has been implemented using custom containers API.
                    // Feel free to convert it to old approach with introducing ActionType enum for each button and just user regular ForEach instead of subviews check.
                    #if os(iOS)
                        ActionsContainer {
                            Button(action: {}) {
                                Label("Top up", icon: theme.images.payment)
                            }

                            Button(action: {}) {
                                Label("Pay", icon: theme.images.receipt)
                            }

                            Button(action: {}) {
                                Label("Send", icon: theme.images.send)
                            }

                            Button(action: manager.toggleTheme) {
                                Label("More", icon: theme.images.table)
                            }
                        }
                        .buttonStyle(.actionButton)
                    #endif
                }
                .padding([.horizontal, .top], theme.metrics.medium)
                .padding(.bottom, theme.metrics.large)
                .background(
                    theme.shapes.creditCardSurface
                        .fill(theme.colors.surfaceSecondary)
                        .ignoresSafeArea(.all)
                )

                TransactionsView()
            }
            .background(theme.colors.surfacePrimary)
        }
        .navigationTitle("My accounts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    theme.images.alert
                }
            }
        }
        .tint(theme.colors.primary)
    }
}

extension SettingsManager {
    fileprivate func toggleTheme() {
        let currentThemeIndex =
            Theme.Source.allCases.firstIndex(of: themeSource)
            ?? Theme.Source.allCases.startIndex
        let nextThemeIndex = (currentThemeIndex + 1) % Theme.Source.allCases.count
        let nextTheme = Theme.Source.allCases[nextThemeIndex]
        theme = .specific(nextTheme)
    }
}

#Preview("Light") {
    NavigationStack {
        AccountsView()
    }
    .themed()
    .environment(\.settingsStorage, .preview(.light))
}

#Preview("Dark") {
    NavigationStack {
        AccountsView()
    }
    .themed()
    .environment(\.settingsStorage, .preview(.dark))
}
