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

    var body: some View {
        NavigationStack {
            ScrollView {
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
                #if !os(watchOS)
                    .padding([.horizontal, .top], theme.metrics.medium)
                    .padding(.bottom, theme.metrics.large)
                    .background(alignment: .center) {
                        theme.shapes.creditCardSurface
                        .fill(theme.colors.surfaceSecondary)
                        .ignoresSafeArea()
                    }
                #endif

                TransactionsView()
            }
            .background(theme.colors.surfacePrimary)
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
        Button {
        } label: {
            Label {
                Text("Top up")
            } icon: {
                fitAndTemplatedImageView(of: theme.images.payment)
            }
        }

        Button {
        } label: {
            Label {
                Text("Pay")
            } icon: {
                fitAndTemplatedImageView(of: theme.images.receipt)
            }
        }
    }

    @ViewBuilder
    private func sendAndMoreButtons() -> some View {
        Button {
        } label: {
            Label {
                Text("Send")
            } icon: {
                fitAndTemplatedImageView(of: theme.images.send)
            }
        }

        Button {
            #if !os(watchOS)
                manager.toggleTheme()
            #endif
        } label: {
            Label {
                Text("More")
            } icon: {
                fitAndTemplatedImageView(of: theme.images.table)
            }
        }
    }

    private func fitAndTemplatedImageView(of image: Image) -> some View {
        image
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
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
