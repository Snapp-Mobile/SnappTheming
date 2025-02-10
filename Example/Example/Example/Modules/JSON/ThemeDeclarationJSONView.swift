//
//  ThemeDeclarationJSONView.swift
//  Example
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

#if !os(watchOS)
    import SwiftUI

    struct ThemeDeclarationJSONView: View {
        @Environment(Theme.self) private var theme

        var body: some View {
            TextEditor(text: .constant(theme.encoded))
                .font(.system(size: 12.0, design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .navigationTitle("Theme JSON")
                #if os(iOS) || targetEnvironment(macCatalyst)
                    .navigationBarTitleDisplayMode(.inline)
                #endif
        }
    }

    #Preview {
        NavigationView {
            ThemeDeclarationJSONView()
                .themed()
                .environment(\.settingsStorage, .preview(.default))
        }
    }
#endif
