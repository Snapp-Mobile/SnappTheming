//
//  ThemeDeclarationJSONView.swift
//  Example
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

#if !os(watchOS) && !os(tvOS)
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
        let manager: SettingsManager = .init(storage: .preview(.default), fallbackColorSchema: .light)
        NavigationView {
            ThemeDeclarationJSONView()
                .themed(with: manager, theme: .constant(.init(manager.themeSource)))
        }
    }
#endif
