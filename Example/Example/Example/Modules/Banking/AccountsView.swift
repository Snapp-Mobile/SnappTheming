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

    #if os(watchOS)
        @State var showDialog: Bool = false
    #endif

    @ViewBuilder
    var content: some View {
        VStack(spacing: theme.metrics.xlarge) {
            CreditCardView()
                #if os(watchOS)
                    .overlay(alignment: .bottomTrailing) {
                        Button {
                            showDialog = true
                        } label: {
                            Image(systemName: "info.circle")
                            .foregroundStyle(theme.colors.primary)
                            .padding(.trailing, theme.metrics.medium)
                            .padding(.bottom, theme.metrics.small)
                        }
                        .buttonStyle(.plain)
                    }
                #endif
            #if !os(watchOS)
                ActionsContainer {
                    topUpAndPayButtons()
                    sendAndMoreButtons()
                }
                .buttonStyle(.actionButton)
            #endif
        }
        #if !os(watchOS) && !os(tvOS)
            .padding([.horizontal, .top], theme.metrics.medium)
            .padding(.bottom, theme.metrics.large)
            .background(alignment: .center) {
                theme.shapes.creditCardSurface
                .fill(theme.colors.surfaceSecondary)
                .ignoresSafeArea()
            }
        #else
            #if os(tvOS)
                .padding([.horizontal, .top], theme.metrics.medium)
                .frame(maxWidth: 400)
            #endif
        #endif

        TransactionsView()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                ViewThatFits {
                    HStack(alignment: .top) {
                        content
                    }
                    .padding(.horizontal)
                    #if !os(tvOS) && !os(macOS)
                        .background(theme.colors.surfacePrimary)
                    #endif

                    VStack(spacing: 0) {
                        content
                    }
                    #if !os(tvOS) && !os(macOS)
                        .background(theme.colors.surfacePrimary)
                    #endif
                    .focusSection()
                }
            }
            .tint(theme.colors.primary)
            .navigationTitle("My accounts")
            #if os(iOS) || targetEnvironment(macCatalyst)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            #if os(watchOS)
                .sheet(isPresented: $showDialog) {
                    VStack {
                        HStack { topUpAndPayButtons() }
                        HStack { sendAndMoreButtons() }
                    }
                    .buttonStyle(.actionButton)
                }
            #endif
        }
    }

    @ViewBuilder
    private func topUpAndPayButtons() -> some View {
        AccountsButton(icon: theme.images.payment, title: "Top up")
        AccountsButton(icon: theme.images.receipt, title: "Pay")
    }

    @ViewBuilder
    private func sendAndMoreButtons() -> some View {
        AccountsButton(icon: theme.images.send, title: "Send")
        AccountsButton(icon: theme.images.table, title: "More") {
            #if !os(watchOS)
                manager.toggleTheme()
            #endif
        }
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
