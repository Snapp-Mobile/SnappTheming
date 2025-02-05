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
        let declarations: SnappThemingAnimationDeclarations
        @FocusState var focusedKey: String?

        var body: some View {
            List {
                Section {
                    ForEach(declarations.keys, id: \.self) { key in
                        LabeledContent(
                            content: {
                                LottieView(animation: try? .from(data: declarations.lego.data))
                                    .playing(loopMode: .loop)
                                    .frame(height: 300, alignment: .trailing)
                            },
                            label: {
                                Text(key)
                                    .foregroundStyle(focusedKey == key ? Color.teal : .primary)
                            }
                        )
                        .focusable(true)
                        .focused($focusedKey, equals: key)
                    }
                }
            }
            .navigationTitle("Animations")
            #if os(iOS) || targetEnvironment(macCatalyst)
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
    }
#endif
