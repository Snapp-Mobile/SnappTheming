//
//  ThemeDeclarationJSONView.swift
//  Example
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

#if os(iOS)
    import SwiftUI

    struct ThemeDeclarationJSONView: View {
        @Environment(Theme.self) private var theme

        var body: some View {
            TextEditor(text: .constant(theme.encoded))
                .font(.system(size: 12.0, design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .navigationTitle("Theme JSON")
                .navigationBarTitleDisplayMode(.inline)
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
