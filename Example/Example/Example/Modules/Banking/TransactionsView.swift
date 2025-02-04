//
//  TransactionsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct TransactionsView: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Recent Transactions")
                    .font(theme.typography.title)
                    .foregroundStyle(theme.colors.textColorPrimary)
                Spacer()
                Button {
                } label: {
                    theme.images.search
                }
            }
            .padding(theme.metrics.medium)

            Divider()

            ScrollView {
                ForEach(
                    Transaction.allCases,
                    content: TransactionItemView.init(transaction:))
            }
        }
    }
}

#Preview {
    TransactionsView()
        .environment(Theme(.light))
}
