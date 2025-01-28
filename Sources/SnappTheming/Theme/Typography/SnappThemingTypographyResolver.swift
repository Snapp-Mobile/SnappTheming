//
//  SnappThemingTypographyResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation
import SwiftUI
import UIKit

/// Resolver for typography in the SnappTheming framework.
public struct SnappThemingTypographyResolver: Sendable, Equatable {
    /// Resolved `UIFont` for UIKit usage.
    public let uiFont: UIFont
    /// Resolved `Font` for SwiftUI usage.
    public let font: Font

    /// Initializes a typography resolver with a given font resolver and font size.
    /// - Parameters:
    ///   - resolver: The font resolver containing the font information.
    ///   - fontSize: The size of the font to resolve.
    public init(_ resolver: SnappThemingFontResolver, fontSize: CGFloat) {
        self.uiFont = resolver.uiFont(size: fontSize)
        self.font = resolver.font(size: fontSize)
    }
}
