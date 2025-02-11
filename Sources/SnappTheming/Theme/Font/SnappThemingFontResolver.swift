//
//  SnappThemingFontResolver.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
    import UIKit
#endif

/// Resolves fonts for theming purposes, supporting custom and system fonts.
public struct SnappThemingFontResolver: Sendable, Equatable {
    /// The font name of the font, if available.
    private let fontName: String?

    /// Initializes a font resolver with an optional font name.
    /// - Parameter fontName: The font name of the font, or `nil` to use the system font.
    public init(fontName: String?) {
        self.fontName = fontName
    }

    #if canImport(UIKit)
        /// Resolves a `UIFont` for the specified size.
        /// - Parameter size: The size of the font.
        /// - Returns: A `UIFont` object. Falls back to the system font if the custom font cannot be resolved.
        public func uiFont(size: CGFloat) -> UIFont {
            (fontName.flatMap { UIFont(name: $0, size: size) }) ?? .systemFont(ofSize: size)
        }
    #endif

    /// Resolves a SwiftUI `Font` for the specified size.
    /// - Parameter size: The size of the font.
    /// - Returns: A SwiftUI `Font`. Falls back to the system font if the custom font cannot be resolved.
    public func font(size: CGFloat) -> Font {
        fontName.map { Font.custom($0, size: size) } ?? .system(size: size)
    }
}

extension SnappThemingFontResolver {
    /// A resolver for the system font.
    public static let system = Self(fontName: nil)
}
