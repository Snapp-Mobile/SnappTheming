//
//  AccountsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct AccountsView: View {
    var declaration: SnappThemingDeclaration

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 24) {
                CreditCardView()
                    .padding([.horizontal, .top], 16)

                ActionsContainer {
                    Button(action: {}) {
                        Label("Top up", systemImage: "creditcard")
                    }

                    Button(action: {}) {
                        Label("Pay", systemImage: "banknote")
                    }

                    Button(action: {}) {
                        Label("Send", systemImage: "paperplane")
                    }

                    Button(action: {}) {
                        Label(
                            "More",
                            systemImage: "tablecells.badge.ellipsis")
                    }
                }
                .buttonStyle(.actionButton)
                .padding(.horizontal, 16)

                HStack {
                    Text("Recent Transactions")
                        .font(.title2)
                    Spacer()
                    Button {
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }

                }
                .padding([.horizontal, .bottom], 16)
            }
            .background(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 16,
                    bottomTrailingRadius: 16,
                    topTrailingRadius: 0,
                    style: .continuous
                )
                .fill(Color.white)
                .ignoresSafeArea(.all)
            )
            .shadow(color: Color.black.opacity(0.15), radius: 5)
            .zIndex(2)

            TransactionsView()
                .padding(.top, 16)
                .zIndex(1)
        }
        .background(Color.black.opacity(0.01))
        .navigationTitle("My accounts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AccountsView(declaration: .bankingLight)
    }
}
