//
//  CreditCardView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct CreditCardView: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.metrics.medium) {
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

            Spacer()

            HStack(alignment: .bottom) {
                Text("•••• 2381")
                    .font(theme.typography.subheadline)
                Spacer()
                Image("mastercard_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: theme.metrics.creditCardNetworkLogoSize)
            }
        }
        .foregroundStyle(theme.colors.textColorPrimaryInverted)
        .padding(theme.metrics.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.creditCard)
        .clipShape(theme.shapes.creditCard)
        .frame(maxWidth: .infinity)
        .aspectRatio(theme.metrics.creditCardAspectRatio, contentMode: .fill)
        .shadow(
            color: theme.colors.shadow,
            radius: theme.metrics.shadowRadius)
    }
}

#Preview {
    CreditCardView()
        .environment(Theme(.light))
        .frame(width: 315, height: 174)
        .padding()
}
