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
        .foregroundStyle(theme.colors.baseWhite)
        #if !os(watchOS)
            .padding([.horizontal], theme.metrics.medium)
        #else
            .padding(theme.metrics.small)
        #endif
        #if os(tvOS) || os(macOS) || os(visionOS)
            .frame(maxWidth: 345, maxHeight: 190)
        #else
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        #endif
        .background(theme.gradients.creditCardSurface)
        .clipShape(theme.shapes.creditCard)
        #if os(tvOS) || os(macOS) || os(visionOS)
            .frame(maxWidth: 385)
        #else
            .frame(maxWidth: .infinity)
        #endif
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
