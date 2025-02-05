//
//  File.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.02.2025.
//

#if canImport(AppKit)
    import AppKit

    extension NSColor {
        /// Resolves an NSColor for a given appearance.
        func resolvedColor(with appearanceName: NSAppearance.Name) -> NSColor {
            guard let appearance = NSAppearance(named: appearanceName) else { return self }
            return self.resolvedColor(with: appearance).usingColorSpace(.sRGB) ?? self
        }

        /// Resolves an `NSColor` for a given `NSAppearance`, ensuring correct light and dark mode handling.
        /// - Parameter appearance: The `NSAppearance` to resolve the color for.
        /// - Returns: The resolved `NSColor`, converted to the sRGB color space for consistency.
        private func resolvedColor(with appearance: NSAppearance) -> NSColor {
            var resolved: NSColor = self

            appearance.performAsCurrentDrawingAppearance {
                if let converted = self.usingColorSpace(.sRGB) {
                    resolved = converted
                }
            }

            return resolved
        }

        /// Compares two `NSColor` instances by converting them to the sRGB color space.
        /// - Parameter other: The color to compare against.
        /// - Returns: `true` if the colors are equal (including alpha), otherwise `false`.
        func isEqual(to other: NSColor) -> Bool {
            guard let color1 = self.usingColorSpace(.sRGB), let color2 = other.usingColorSpace(.sRGB)
            else { return false }

            return color1.redComponent == color2.redComponent
                && color1.greenComponent == color2.greenComponent
                && color1.blueComponent == color2.blueComponent
                && color1.alphaComponent == color2.alphaComponent
        }

        /// Creates an `NSColor` from a hex string, supporting 12-bit, 24-bit, and 32-bit formats.
        /// - Parameters:
        ///   - hex: A hex string in `#RGB`, `#RRGGBB`, `#AARRGGBB`, or `#RRGGBBAA` format.
        ///   - format: The color format to use (`.rgba` or `.argb` for 8-character hex).
        /// - Returns: An optional `NSColor` if the conversion succeeds.
        static func fromHex(
            _ hex: String, using format: SnappThemingColorFormat = .rgba
        ) -> NSColor? {
            var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)

            // Remove "#" if present
            if cleanedHex.hasPrefix("#") {
                cleanedHex.removeFirst()
            }

            // Convert hex string to integer
            var hexValue: UInt64 = 0
            guard Scanner(string: cleanedHex).scanHexInt64(&hexValue) else {
                return nil
            }

            let red: Double
            let green: Double
            let blue: Double
            let alpha: Double

            switch cleanedHex.count {
            case 3:  // RGB (12-bit) -> Convert to 24-bit
                let r = (hexValue >> 8) & 0xF
                let g = (hexValue >> 4) & 0xF
                let b = hexValue & 0xF
                red = Double(r * 17) / 255.0
                green = Double(g * 17) / 255.0
                blue = Double(b * 17) / 255.0
                alpha = 1.0

            case 6:  // RGB (24-bit)
                red = Double((hexValue >> 16) & 0xFF) / 255.0
                green = Double((hexValue >> 8) & 0xFF) / 255.0
                blue = Double(hexValue & 0xFF) / 255.0
                alpha = 1.0

            case 8:  // RGBA or ARGB (32-bit)
                if format == .rgba {
                    red = Double((hexValue >> 24) & 0xFF) / 255.0
                    green = Double((hexValue >> 16) & 0xFF) / 255.0
                    blue = Double((hexValue >> 8) & 0xFF) / 255.0
                    alpha = Double(hexValue & 0xFF) / 255.0
                } else {  // .argb
                    alpha = Double((hexValue >> 24) & 0xFF) / 255.0
                    red = Double((hexValue >> 16) & 0xFF) / 255.0
                    green = Double((hexValue >> 8) & 0xFF) / 255.0
                    blue = Double(hexValue & 0xFF) / 255.0
                }

            default: return nil
            }

            return NSColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
#endif
