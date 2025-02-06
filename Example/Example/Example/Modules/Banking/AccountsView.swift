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
    #if os(watchOS)
        @State var showDialog: Bool = false
    #endif

    var body: some View {
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
                        Button(action: {}) {
                            Label("Top up", icon: theme.images.payment)
                        }

                        Button(action: {}) {
                            Label("Pay", icon: theme.images.receipt)
                        }

                        Button(action: {}) {
                            Label("Send", icon: theme.images.send)
                        }

                        Button(action: {}) {
                            Label("More", icon: theme.images.table)
                        }
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
        .navigationTitle("My accounts")
        .tint(theme.colors.primary)
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {}) {
                        theme.images.alert
                    }
                }
            }
        #endif
        #if os(watchOS)
            .sheet(isPresented: $showDialog) {
                VStack {
                    HStack {
                        Button(action: {}) {
                            Label {
                                Text("Top up")
                            } icon: {
                                theme.images.payment
                            }
                        }

                        Button(action: {}) {
                            Label {
                                Text("Pay")
                            } icon: {
                                theme.images.receipt
                            }
                        }
                    }

                    HStack {
                        Button(action: {}) {
                            Label {
                                Text("Send")
                            } icon: {
                                theme.images.send
                            }
                        }

                        Button(action: {}) {
                            Label {
                                Text("More")
                            } icon: {
                                theme.images.table
                            }
                        }
                    }
                }
            }
        #endif
    }
}

#Preview("Light") {
    NavigationStack {
        AccountsView()
    }
    .environment(Theme(.light))
}

#Preview("Dark") {
    NavigationStack {
        AccountsView()
    }
    .environment(Theme(.dark))
}
