//
//  TransactionsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct TransactionsView: View {
    let declaration: SnappThemingDeclaration

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Recent Transactions")
                    .font(declaration.typography.title)
                Spacer()
                Button {
                } label: {
                    declaration.images.search
                }
            }
            .padding(declaration.metrics.medium)
            .background(declaration.colors.surfacePrimary)

            Divider()

            ScrollView {
                ForEach(Transaction.allCases) {
                    TransactionItemView(declaration: declaration, transaction: $0)
                }
            }
        }
    }
}

#Preview {
    TransactionsView(declaration: .bankingLight)
}
