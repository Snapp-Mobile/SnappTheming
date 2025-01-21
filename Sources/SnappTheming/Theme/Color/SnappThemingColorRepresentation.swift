//
//  SnappThemingColorRepresentation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import SwiftUI
import UIKit

/// A representation of color in the SnappTheming framework.
public enum SnappThemingColorRepresentation: Codable {
    /// A color represented by a hexadecimal string (e.g., "#FF5733").
    case hex(String)

    /// A dynamic color that can change depending on system settings (e.g., light/dark mode).
    case dynamic(SnappThemingDynamicColor)

    /// Decodes a `SnappThemingColorRepresentation` from the provided decoder.
    /// It checks if the decoded value is a string (for hex) or a dynamic color.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .hex(stringValue)
        } else {
            self = try .dynamic(container.decode(SnappThemingDynamicColor.self))
        }
    }

    /// Encodes the `SnappThemingColorRepresentation` to the provided encoder.
    /// Depending on the case, it encodes either a hex string or a dynamic color.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .hex(let value):
            try container.encode(value)
        case .dynamic(let value):
            try container.encode(value)
        }
    }
}

extension SnappThemingColorRepresentation {
    func color(using format: SnappThemingColorFormat) -> Color {
        switch self {
        case .dynamic(let dynamicColor):
            dynamicColor.color(using: format)
        case .hex(let hexValue):
            Color(hex: hexValue, format: format)
        }
    }

    func uiColor(using format: SnappThemingColorFormat) -> UIColor {
        switch self {
        case .dynamic(let dynamicColor):
            dynamicColor.uiColor(using: format)
        case .hex(let hexValue):
            UIColor(hex: hexValue, format: format)
        }
    }
}
