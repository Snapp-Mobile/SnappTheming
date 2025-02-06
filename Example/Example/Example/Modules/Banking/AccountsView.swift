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

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: theme.metrics.xlarge) {
                    CreditCardView()

//                    ActionsContainer {
//                        Button(action: {}) {
//                            Label("Top up", icon: theme.images.payment)
//                        }
//
//                        Button(action: {}) {
//                            Label("Pay", icon: theme.images.receipt)
//                        }
//
//                        Button(action: {}) {
//                            Label("Send", icon: theme.images.send)
//                        }
//
//                        Button(action: {}) {
//                            Label("More", icon: theme.images.table)
//                        }
//                    }
//                    .buttonStyle(.actionButton)
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

#Preview("Light") {
    AccountsView()
        .environment(Theme(.light))
}

#Preview("Dark") {
    AccountsView()
        .environment(Theme(.dark))
}
