//
//  AnimationsViewer.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 16.12.24.
//

import Lottie
import SnappTheming
import SnappThemingSwiftUIHelpers
import SwiftUI

struct AnimationsViewer: View {
    @Environment(Theme.self) private var theme

    var body: some View {
        List {
            Section {
                ForEach(theme.animations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        LottieView(animation: try? .from(data: theme.animations.lego.data))
                            .playing(loopMode: .loop)
                            .frame(height: 300)
                    }
                }
            }
        }
        .navigationTitle("Animations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AnimationsViewer()
        .environment(Theme(.default))
}
