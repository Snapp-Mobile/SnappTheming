//
//  CreditCardView.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import SnappTheming
import SnappThemingSwiftUIHelpers
import SwiftUI

struct CreditCardView: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.metrics.medium) {
            CreditCardHeaderView()

            Spacer()

            CreditCardFooterView()
        }
        .foregroundStyle(theme.colors.textColorPrimaryInverted)
        #if !os(watchOS)
            .padding([.horizontal], theme.metrics.medium)
        #else
            .padding(theme.metrics.small)
        #endif
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.gradients.creditCardSurface)
        .clipShape(theme.shapes.creditCard)
        .frame(maxWidth: .infinity)
        .aspectRatio(theme.metrics.creditCardAspectRatio, contentMode: .fill)
        .shadow(
            color: theme.colors.shadow,
            radius: theme.metrics.shadowRadius
        )
        #if os(watchOS)
            .padding(.horizontal, theme.metrics.small)
        #endif
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

#Preview("Colorful") {
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed()
        .environment(\.settingsStorage, .preview(.colorful))
}
