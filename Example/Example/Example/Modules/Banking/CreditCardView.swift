//
//  CreditCardView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SnappThemingSwiftUIHelpers
import SwiftUI

#if !os(watchOS)
    import Lottie
#endif

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

                Text(
                    3120.7,
                    format: .currency(code: "EUR").precision(.fractionLength(1))
                )
                .font(theme.typography.largeTitle)
            }
            .padding(.top, theme.metrics.medium)

            Spacer()

            HStack(alignment: .bottom) {
                Text("•••• 2381")
                    .font(theme.typography.subheadline)
                    .padding(.bottom, theme.metrics.medium)
                Spacer()
                #if !os(watchOS)
                    LottieView(
                        animation: try? .from(data: theme.animations.visa.data)
                    )
                    .playing()
                    .playing(loopMode: .loop)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: theme.metrics.creditCardNetworkLogoSize)
                #endif
            }
        }
        .foregroundStyle(theme.colors.textColorPrimaryInverted)
        .padding([.horizontal], theme.metrics.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.gradients.creditCardSurface)
        .clipShape(theme.shapes.creditCard)
        .frame(maxWidth: .infinity)
        .aspectRatio(theme.metrics.creditCardAspectRatio, contentMode: .fill)
        .shadow(
            color: theme.colors.shadow,
            radius: theme.metrics.shadowRadius)
    }
}

#Preview("Light") {
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed()
        .environment(\.settingsStorage, .preview(.light))
}

#Preview("Dark") {
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed()
        .environment(\.settingsStorage, .preview(.dark))
}
