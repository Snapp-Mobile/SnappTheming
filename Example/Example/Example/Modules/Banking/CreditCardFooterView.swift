//
//  CreditCardFooterView.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 06.02.2025.
//

import SwiftUI

#if !os(watchOS)
    import Lottie
#endif

struct CreditCardFooterView: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        #if os(watchOS)
            Text("•••• 2381")
                .font(theme.typography.subheadline)
                .frame(alignment: .bottomLeading)
        #else
            HStack(alignment: .bottom) {
                Text("•••• 2381")
                    .font(theme.typography.subheadline)
                    .padding(.bottom, theme.metrics.medium)
                Spacer()
                LottieView(
                    animation: try? .from(data: theme.animations.visa.data)
                )
                .playing()
                .playing(loopMode: .loop)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: theme.metrics.creditCardNetworkLogoSize)
            }
        #endif
    }
}
