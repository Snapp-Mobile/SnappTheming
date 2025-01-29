//
//  TransactionItemView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SwiftUI

struct TransactionItemView: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(transaction.identity.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .frame(width: 40, height: 40)
            .background(Color.black)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 0) {
                Text(transaction.identity.name)
                    .font(.headline)
                Text(transaction.category.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 0) {
                Text(transaction.amount, format: .currency(code: "EUR"))
                    .font(.headline)
                    .foregroundColor(transaction.amount < 0 ? .red : .green)
                Text(transaction.date, format: .relative(presentation: .named))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    VStack(spacing: 0) {
        ForEach(Transaction.allCases) {
            TransactionItemView(transaction: $0)
        }
    }
}
