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
        @Environment(Theme.self) private var theme
        @FocusState private var focusedKey: String?

        var body: some View {
            List {
                Section {
                    ForEach(theme.animations.keys, id: \.self) { key in
                        LabeledContent {
                            LottieView(animation: try? .from(data: theme.animations[dynamicMember: key].data))
                                .playing(loopMode: .loop)
                                .frame(height: 300, alignment: .trailing)
                        } label: {
                            Text(key)
                                .foregroundStyle(focusedKey == key ? Color.teal : .primary)
                        }
                    }
                }
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
