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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                #if !os(watchOS)
                    Spacer()
                    Button {
                    } label: {
                        theme.images.search
                    }
                #endif
            }
            .padding(theme.metrics.medium)

            Divider()

            ForEach(Transaction.allCases, content: TransactionItemView.init(transaction:))
        }
    }
}

#Preview {
    TransactionsView()
        .environment(Theme(.light))
}
