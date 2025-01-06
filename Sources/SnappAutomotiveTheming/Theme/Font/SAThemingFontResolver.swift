//
//  SAThemingFontResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import UIKit
import SwiftUI

public struct SAThemingFontResolver: Sendable {
    private let fontName: String?

    public init(fontName: String?) {
        self.fontName = fontName
    }

    public func uiFont(size: CGFloat) -> UIFont {
        (fontName.map { UIFont(name: $0, size: size) } ?? nil) ?? .systemFont(ofSize: size)
    }

    public func font(size: CGFloat) -> Font {
        fontName.map { Font.custom($0, size: size) } ?? .system(size: size)
    }
}

public extension SAThemingFontResolver {
    static let system = Self(fontName: nil)
}
