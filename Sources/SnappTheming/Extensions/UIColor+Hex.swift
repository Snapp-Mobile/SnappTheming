//
//  UIColor+Hex.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

#if canImport(UIKit)
    import UIKit

    extension UIColor {
        public convenience init(hex: String, alpha: Double = 1.0, format: SnappThemingColorFormat = .rgba) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let cAlpha: Double
            let red: UInt64
            let green: UInt64
            let blue: UInt64
            switch (hex.count, format) {
            case (3, _):  // RGB (12-bit)
                (cAlpha, red, green, blue) = (alpha, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case (6, _):  // RGB (24-bit)
                (cAlpha, red, green, blue) = (alpha, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case (8, .rgba):
                (red, green, blue, cAlpha) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, Double(int & 0xFF) / 255)
            case (8, .argb):
                (cAlpha, red, green, blue) = (Double(int >> 24) / 255, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (cAlpha, red, green, blue) = (alpha, 1, 1, 0)
            }

            self.init(
                red: Double(red) / 255,
                green: Double(green) / 255,
                blue: Double(blue) / 255,
                alpha: cAlpha
            )
        }
    }
#endif
