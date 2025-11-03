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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

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
        .frame(
            maxWidth: isCompact ? .infinity : 345,
            maxHeight: isCompact ? .infinity : 190
        )
        .background(theme.gradients.creditCardSurface)
        .clipShape(theme.shapes.creditCard)
        .frame(
            maxWidth: isCompact ? .infinity : 385,
            maxHeight: isCompact ? .infinity : 230
        )
        .aspectRatio(theme.metrics.creditCardAspectRatio, contentMode: .fill)
        .shadow(theme.shadows.card)
        #if os(watchOS)
            .padding(.horizontal, theme.metrics.small)
        #endif
    }
}

#Preview("Light") {
    let manager: SettingsManager = .init(storage: .preview(.light), fallbackColorSchema: .light)
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed(with: manager, theme: .constant(Theme(manager.themeSource)))
}

#Preview("Dark") {
    let manager: SettingsManager = .init(storage: .preview(.dark), fallbackColorSchema: .dark)
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed(with: manager, theme: .constant(Theme(manager.themeSource)))
}

#Preview("Colorful") {
    let manager: SettingsManager = .init(storage: .preview(.colorful), fallbackColorSchema: .light)
    CreditCardView()
        .frame(width: 315, height: 174)
        .themed(with: manager, theme: .constant(Theme(manager.themeSource)))
}
