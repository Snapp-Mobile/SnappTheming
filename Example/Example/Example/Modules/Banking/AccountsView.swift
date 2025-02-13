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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

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
                #if os(tvOS)
                    .focusSection()
                #endif
            #endif
        }
        #if !os(watchOS) && !os(tvOS) && !os(visionOS)
            .padding([.horizontal, .top], theme.metrics.medium)
            .padding(.bottom, theme.metrics.large)
            .background(alignment: .center) {
                theme.shapes.creditCardSurface
                .fill(theme.colors.surfaceSecondary)
                .ignoresSafeArea()
            }
        #else
            #if os(tvOS) || os(visionOS)
                .padding([.horizontal, .top], theme.metrics.medium)
            #endif
        #endif
        .frame(maxWidth: isCompact ? .infinity : 400)

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
                    #if !os(tvOS) && !os(macOS) && !os(visionOS)
                        .background(theme.colors.surfacePrimary)
                    #endif

                    VStack(spacing: 0) {
                        content
                    }
                    #if !os(tvOS) && !os(macOS) && !os(visionOS)
                        .background(theme.colors.surfacePrimary)
                    #endif
                    #if os(macOS) || os(tvOS)
                        .focusSection()
                    #endif
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .tint(theme.colors.primary)
            #if !os(tvOS) && !os(visionOS)
                .background(theme.colors.surfacePrimary)
            #endif
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
        @Bindable var manager = manager
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
    let manager: SettingsManager = .init(storage: .preview(.light), fallbackColorSchema: .light)
    NavigationStack {
        AccountsView()
    }
    .themed(with: manager, theme: .constant(.init(manager.themeSource)))
}

#Preview("Dark") {
    let manager: SettingsManager = .init(storage: .preview(.dark), fallbackColorSchema: .dark)
    NavigationStack {
        AccountsView()
    }
    .themed(with: manager, theme: .constant(.init(manager.themeSource)))
}
