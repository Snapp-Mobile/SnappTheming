//
//  CreditCardView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SwiftUI

struct CreditCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .center) {
                Image("snapp_themeing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48)
                Text("Snapp")
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Spacer()

                Text(3120.7, format: .currency(code: "EUR").precision(.fractionLength(1)))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .font(.headline)

            Spacer()

            HStack(alignment: .bottom) {
                Text("••••")
                    .foregroundColor(.white)
                Text("2020")
                    .foregroundColor(.white)
                Spacer()
                Image("mastercard_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 40)
            }
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1.81, contentMode: .fill)
        .shadow(radius: 10)
    }
}

#Preview {
    CreditCardView()
        .frame(width: 315, height: 174)
        .padding()
}
