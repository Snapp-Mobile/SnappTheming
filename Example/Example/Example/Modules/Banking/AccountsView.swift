//
//  AccountsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct AccountsView: View {
    let declaration: SnappThemingDeclaration

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: declaration.metrics.xlarge) {
                CreditCardView(declaration: declaration)

                ActionsContainer {
                    Button(action: {}) {
                        Label("Top up", icon: declaration.images.payment)
                    }

                    Button(action: {}) {
                        Label("Pay", icon: declaration.images.receipt)
                    }

                    Button(action: {}) {
                        Label("Send", icon: declaration.images.send)
                    }

                    Button(action: {}) {
                        Label("More", icon: declaration.images.table)
                    }
                }
                .buttonStyle(.actionButton)
            }
            .padding([.horizontal, .top], declaration.metrics.medium)
            .padding(.bottom, declaration.metrics.large)
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 16,
                    bottomTrailingRadius: 16,
                    topTrailingRadius: 0,
                    style: .continuous
                )
                .fill(declaration.colors.surfaceSecondary)
                .ignoresSafeArea(.all)
            )
            .shadow(color: Color.black.opacity(0.15), radius: 5)

            TransactionsView(declaration: declaration)
        }
        .background(declaration.colors.surfacePrimary)
        .navigationTitle("My accounts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    declaration.images.alert
                }
            }
        }
        .tint(declaration.colors.primary)
    }
}

#Preview {
    NavigationStack {
        AccountsView(declaration: .bankingLight)
    }
}
