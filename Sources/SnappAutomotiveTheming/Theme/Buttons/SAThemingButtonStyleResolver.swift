//
//  SAThemingButtonStyleResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingButtonStyleResolver: Sendable {
    public let surfaceColor: SAThemingInteractiveColor
    public let textColor: SAThemingInteractiveColor
    public let borderColor: SAThemingInteractiveColor
    public let borderWidth: Double
    public let shape: SAThemingButtonStyleShape
    public let typography: SAThemingTypographyResolver

    init(surfaceColor: SAThemingInteractiveColor, textColor: SAThemingInteractiveColor, borderColor: SAThemingInteractiveColor, borderWidth: Double, shape: SAThemingButtonStyleShape, typography: SAThemingTypographyResolver) {
        self.surfaceColor = surfaceColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shape = shape
        self.typography = typography
    }

    public static func empty() -> Self {
        SAThemingButtonStyleResolver(
            surfaceColor: .clear,
            textColor: .clear,
            borderColor: .clear,
            borderWidth: 0.0,
            shape: .init(),
            typography: .init(SAThemingFontResolver(fontName: "SFProText"), fontSize: 102.0)
        )
    }
}
