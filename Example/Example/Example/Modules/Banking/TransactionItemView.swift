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
                HStack(alignment: .firstTextBaseline) {
                    Text(transaction.identity.name)
                        .foregroundStyle(theme.colors.textColorPrimary)
                    Spacer()
                    Text(transaction.amount, format: .currency(code: "EUR"))
                        .foregroundStyle(
                            transaction.amount < 0 ? theme.colors.red : theme.colors.green
                        )
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                .font(theme.typography.headline)

                HStack(alignment: .firstTextBaseline) {
                    Text(transaction.category.rawValue)
                    Spacer()
                    Text(transaction.date, format: .relative(presentation: .named))
                }
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .font(theme.typography.subheadline)
                .foregroundStyle(theme.colors.textColorSecondary)
            }
        }
        #if !os(watchOS)
            .padding(.horizontal, theme.metrics.medium)
        #else
            .padding(.horizontal, theme.metrics.small)
        #endif
        .padding(.vertical, theme.metrics.small)
        #if !os(macOS) && !os(tvOS)
            .background(theme.colors.surfacePrimary)
        #endif
    }
}

#Preview("Light") {
    VStack(spacing: 0) {
        ForEach(
            Transaction.allCases,
            content: TransactionItemView.init(transaction:))
    }
    .themed()
    .environment(\.settingsStorage, .preview(.light))
}

#Preview("Dark") {
    VStack(spacing: 0) {
        ForEach(
            Transaction.allCases,
            content: TransactionItemView.init(transaction:))
    }
    .themed()
    .environment(\.settingsStorage, .preview(.light))
}
