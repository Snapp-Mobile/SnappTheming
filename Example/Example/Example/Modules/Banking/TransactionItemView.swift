//
//  TransactionItemView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct TransactionItemView: View {
    let declaration: SnappThemingDeclaration
    let transaction: Transaction

    var body: some View {
        HStack(spacing: declaration.metrics.medium) {
            let imageSize: CGFloat = declaration.metrics.transactionIconSize
            ZStack {
                Image(transaction.identity.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageSize, height: imageSize)
            }
            .frame(width: imageSize, height: imageSize)
            .background(declaration.colors.baseBlack)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: declaration.metrics.xsmall) {
                HStack {
                    Text(transaction.identity.name)
                    Spacer()
                    Text(transaction.amount, format: .currency(code: "EUR"))
                }
                .font(declaration.typography.headline)
                .foregroundStyle(declaration.colors.textColorPrimary)

                HStack {
                    Text(transaction.category.rawValue)
                    Spacer()
                    Text(transaction.date, format: .relative(presentation: .named))
                }
                .font(declaration.typography.subheadline)
                .foregroundStyle(declaration.colors.textColorSecondary)
            }
        }
        .padding(.horizontal, declaration.metrics.medium)
        .padding(.vertical, declaration.metrics.small)
    }
}

#Preview {
    VStack(spacing: 0) {
        ForEach(Transaction.allCases) {
            TransactionItemView(
                declaration: .bankingLight,
                transaction: $0)
        }
    }
}
