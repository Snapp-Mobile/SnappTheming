//
//  SnappThemingButtonStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SnappThemingButtonStyleResolver: Sendable {
    public let surfaceColor: SnappThemingInteractiveColor
    public let textColor: SnappThemingInteractiveColor
    public let borderColor: SnappThemingInteractiveColor
    public let borderWidth: Double
    public let shape: SnappThemingButtonStyleType
    public let typography: SnappThemingTypographyResolver

    init(surfaceColor: SnappThemingInteractiveColor, textColor: SnappThemingInteractiveColor, borderColor: SnappThemingInteractiveColor, borderWidth: Double, shape: SnappThemingButtonStyleType, typography: SnappThemingTypographyResolver) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shape = shape
        self.typography = typography
    }

    public static func empty() -> Self {
        SnappThemingButtonStyleResolver(
            surfaceColor: .clear,
            textColor: .clear,
            borderColor: .clear,
            borderWidth: 0.0,
            shape: .rectangle,
            typography: .init(SnappThemingFontResolver(fontName: "SFProText"), fontSize: 102.0)
        )
    }
}
