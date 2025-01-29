//
//  TransactionsView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Transaction.allCases, content: TransactionItemView.init(transaction:))
            }
        }
        .scrollClipDisabled()
    }
}

#Preview {
    TransactionsView()
}
