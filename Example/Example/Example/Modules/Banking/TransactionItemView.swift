//
//  TransactionItemView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct TransactionItemView: View {
    @Environment(Theme.self) private var theme
    let transaction: Transaction

    var body: some View {
        HStack(spacing: theme.metrics.medium) {
            let imageSize: CGFloat = theme.metrics.transactionIconSize
            ZStack {
                Image(transaction.identity.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
            }
            .frame(width: imageSize, height: imageSize)
            .background(theme.colors.baseBlack)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: theme.metrics.xsmall) {
                HStack {
                    Text(transaction.identity.name)
                        .foregroundStyle(theme.colors.textColorPrimary)
                    Spacer()
                    Text(transaction.amount, format: .currency(code: "EUR"))
                        .foregroundStyle(
                            transaction.amount < 0
                                ? theme.colors.red : theme.colors.green
                        )
                }
                .font(theme.typography.headline)

                HStack {
                    Text(transaction.category.rawValue)
                    Spacer()
                    Text(
                        transaction.date,
                        format: .relative(presentation: .named))
                }
                .font(theme.typography.subheadline)
                .foregroundStyle(theme.colors.textColorSecondary)
            }
        }
        .padding(.horizontal, theme.metrics.medium)
        .padding(.vertical, theme.metrics.small)
        .background(theme.colors.surfacePrimary)
    }
}

#Preview("Light") {
    VStack(spacing: 0) {
        ForEach(
            Transaction.allCases,
            content: TransactionItemView.init(transaction:))
    }
    .environment(Theme(.light))
}

#Preview("Dark") {
    VStack(spacing: 0) {
        ForEach(
            Transaction.allCases,
            content: TransactionItemView.init(transaction:))
    }
    .environment(Theme(.dark))
}
