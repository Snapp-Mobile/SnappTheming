//
//  SAThemingDynamicColor.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import SwiftUI

public struct SAThemingDynamicColor: Codable {
    private let light: String
    private let dark: String

    public func uiColor(using colorFormat: SAThemingColorFormat) -> UIColor {
        return UIColor { (traits) -> UIColor in
            // Return one of two colors depending on light or dark mode
            return traits.userInterfaceStyle == .dark ?
            UIColor(hex: dark, format: colorFormat) :
            UIColor(hex: light, format: colorFormat)
        }
    }

    public func color(using colorFormat: SAThemingColorFormat) -> Color {
        return Color(uiColor: uiColor(using: colorFormat))
    }
}
