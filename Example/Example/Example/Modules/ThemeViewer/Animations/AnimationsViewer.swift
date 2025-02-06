//
//  AnimationsViewer.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 16.12.24.
//
#if !os(watchOS)
    import Lottie
    import SnappTheming
    import SnappThemingSwiftUIHelpers
    import SwiftUI

    struct AnimationsViewer: View {
        @FocusState var focusedKey: String?

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
						.focusable(true)
                        .focused($focusedKey, equals: key)
                    }
                }
                .navigationTitle("Animations")
                #if os(iOS) || targetEnvironment(macCatalyst)
                    .navigationBarTitleDisplayMode(.inline)
                #endif
            }
            .navigationTitle("Animations")
            #if os(iOS) || targetEnvironment(macCatalyst)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }

    #Preview {
        AnimationsViewer()
            .environment(Theme(.default))
    }
#endif
