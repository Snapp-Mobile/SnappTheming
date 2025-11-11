//
//  ShadowsViewer.swift
//  Example
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import SwiftUI

struct ShadowsViewer: View {
    @Environment(Theme.self) private var theme
    @FocusState var focusedKey: String?

    var body: some View {
        List {
            Section {
                ForEach(theme.shadows.keys, id: \.self) { key in

                    ZStack {
                        // Background to make shadow visible
                        theme.colors.surfacePrimary
                            .ignoresSafeArea()

                        let shadow = theme.shadows[dynamicMember: key]
                        RoundedRectangle(cornerRadius: 24)
                            .fill(theme.colors.surfacePrimary)
                            .frame(height: 120)
                            .shadow(
                                color: shadow.color,
                                radius: shadow.radius,
                                x: shadow.x,
                                y: shadow.y
                            )
                            .padding(40)

                        Text("\(key)")
                    }
                }
            }
        }
        .navigationTitle("Shadows")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    ShadowsViewer()
}
