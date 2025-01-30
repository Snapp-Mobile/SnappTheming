//
//  Color+Hex.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import OSLog
import SwiftUI

extension Color {
    /// Creates a `Color` instance from a hexadecimal string representation.
    ///
    /// This initializer supports RGB (12-bit and 24-bit) and ARGB/RGBA (32-bit) color formats.
    ///
    /// - Parameters:
    ///   - hex: A string containing a hexadecimal color representation (e.g., `"#FF5733"` or `"FF5733"`).
    ///          Non-hexadecimal characters are ignored.
    ///   - alpha: The alpha (opacity) value of the color. Defaults to `1.0` (fully opaque).
    ///   - format: The format of the hexadecimal representation. Defaults to `.rgba`.
    ///
    /// - Note: If the input `hex` string is invalid or its format doesn't match the expected length, the initializer
    ///         defaults to a fallback color (red with 100% opacity).
    public init(
        hex: String,
        alpha: Double = 1.0,
        format: SnappThemingColorFormat = .rgba
    ) {
        // Normalize the hex string by removing any invalid characters.
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        guard !hex.isEmpty else {
            os_log(.error, "Invalid or empty hex string: %@", hex)
            self.init(.sRGB, red: 1.0, green: 0.0, blue: 0.0, opacity: alpha)  // Fallback to red color.
            return
        }

        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)  // Safely parse the hex string.

        let cAlpha: Double
        let red: UInt64
        let green: UInt64
        let blue: UInt64

        switch (hex.count, format) {
        case (3, _):  // RGB (12-bit)
            (cAlpha, red, green, blue) = (
                alpha,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
        case (6, _):  // RGB (24-bit)
            (cAlpha, red, green, blue) = (
                alpha,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        case (8, .rgba):  // RGBA (32-bit)
            (red, green, blue, cAlpha) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                Double(int & 0xFF) / 255
            )
        case (8, .argb):  // ARGB (32-bit)
            (cAlpha, red, green, blue) = (
                Double(int >> 24) / 255,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            os_log(.error, "Unsupported hex string length (%d) or format: %@", hex.count, "\(format)")
            (cAlpha, red, green, blue) = (alpha, 255, 0, 0)  // Fallback to red color.
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: cAlpha
        )
    }
    #if canImport(UIKit)
        /// Converts the `Color` instance into a `UIColor`.
        ///
        /// - Returns: A `UIColor` representation of the current `Color`. Returns `.clear` if the conversion fails.
        public var uiColor: UIColor {
            guard let cgColor else {
                os_log(.error, "Failed to retrieve CGColor from Color")
                return .clear
            }
            return UIColor(cgColor: cgColor)
        }
    #endif
}
