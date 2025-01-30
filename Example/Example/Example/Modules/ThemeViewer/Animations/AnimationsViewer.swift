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
    let declarations: SnappThemingAnimationDeclarations

    var body: some View {
        List {
            Section {
                ForEach(declarations.keys, id: \.self) { key in
                    LabeledContent(key) {
                        LottieView(animation: try? .from(data: declarations.lego.data))
                            .playing(loopMode: .loop)
                            .frame(height: 300)
                    }
                }
            }
        }
        .navigationTitle("Animations")
        #if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
