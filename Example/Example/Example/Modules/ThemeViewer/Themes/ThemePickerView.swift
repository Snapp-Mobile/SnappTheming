//
//  ThemePickerView.swift
//  Example
//
//  Created by Ilian Konchev on 5.02.25.
//

import OSLog
import SwiftUI

struct ThemePickerView: View {
    var currentThemeName: String?
    var onThemeChange: (AvailableTheme) -> Void

    var body: some View {
        List {
            Section {
                ForEach(AvailableTheme.allCases, id: \.self) { theme in
                    Button(
                        action: {
                            onThemeChange(theme)
                        },
                        label: {
                            Label(
                                title: {
                                    Text(theme.description)
                                },
                                icon: {
                                    Image(
                                        systemName: theme.configuration.themeName == currentThemeName
                                            ? "paintbrush.fill"
                                            : "paintbrush"
                                    )
                                })
                        })
                }
            }
        }
        .navigationTitle("Theme Picker")
        #if os(iOS) || targetEnvironment(macCatalyst)
            .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    ThemePickerView(
        currentThemeName: AvailableTheme.day.description,
        onThemeChange: { theme in
            os_log(.debug, "Theme changed to %@", theme.description)
        })
}
