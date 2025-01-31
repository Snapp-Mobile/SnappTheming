//
//  CreditCardView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SwiftUI

struct CreditCardView: View {
    let declaration: SnappThemingDeclaration

    var body: some View {
        VStack(alignment: .leading, spacing: declaration.metrics.medium) {
            HStack(alignment: .center) {
                Image("snapp_themeing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: declaration.metrics.creditCardLogoSize)
                Text("Snapp")
                    .font(declaration.typography.title)

                Spacer()

                Text(3120.7, format: .currency(code: "EUR").precision(.fractionLength(1)))
                    .font(declaration.typography.largeTitle)
            }

            Spacer()

            HStack(alignment: .bottom) {
                Text("•••• 2381")
                    .font(declaration.typography.subheadline)
                Spacer()
                Image("mastercard_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: declaration.metrics.creditCardNetworkLogoSize)
            }
        }
        .foregroundStyle(declaration.colors.textColorPrimaryInverted)
        .padding(declaration.metrics.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: declaration.metrics.medium)
                .fill(declaration.colors.baseBlack)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(declaration.metrics.creditCardAspectRatio, contentMode: .fill)
        .shadow(radius: declaration.metrics.medium)
    }
}

#Preview {
    CreditCardView(declaration: .bankingLight)
        .frame(width: 315, height: 174)
        .padding()
}
