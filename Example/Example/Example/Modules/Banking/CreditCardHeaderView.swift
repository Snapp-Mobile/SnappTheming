//
//  CreditCardHeaderView.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 06.02.2025.
//

import SwiftUI

struct CreditCardHeaderView: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        #if os(watchOS)
            VStack(alignment: .leading) {
                HStack {
                    Image("snapp_themeing_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: theme.metrics.large,
                            height: theme.metrics.large)
                    Text(3120.7, format: .currency(code: "EUR").precision(.fractionLength(1)))
                        .font(theme.typography.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text("Snapp")
                    .font(theme.typography.title)
            }

        #else
            HStack(alignment: .center) {
                Image("snapp_themeing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: theme.metrics.creditCardLogoSize)
                Text("Snapp")
                    .font(theme.typography.title)

                Spacer()

                Text(3120.7, format: .currency(code: "EUR").precision(.fractionLength(1)))
                    .font(theme.typography.largeTitle)
            }
            .padding(.top, theme.metrics.medium)

        #endif
    }
}
