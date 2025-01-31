//
//  Color+toHex.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 31.01.2025.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

extension Color {
    /// Converts a `Color` instance to a hexadecimal string representation.
    ///
    /// - Parameter includeAlpha: If `true`, includes the alpha value in the hex string (e.g., `#RRGGBBAA`).
    /// - Returns: A string representing the color in hex format.
    func toHex() -> String? {
        #if canImport(UIKit)
            let components = UIColor(self).cgColor.components
        #elseif canImport(AppKit)
            let components = NSColor(self).cgColor.components
        #endif

        guard let components, components.count >= 3 else {
            return nil
        }

        let r = Int((components[0] * 255).rounded())
        let g = Int((components[1] * 255).rounded())
        let b = Int((components[2] * 255).rounded())
        let a = Int(((components.count > 3 ? components[3] : 1) * 255).rounded())

        let includeAlpha = a < 1

        return includeAlpha
            ? String(format: "#%02X%02X%02X%02X", r, g, b, a)
            : String(format: "#%02X%02X%02X", r, g, b)
    }
}
