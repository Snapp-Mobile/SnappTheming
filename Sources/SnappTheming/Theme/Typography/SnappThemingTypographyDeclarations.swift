//
//  SnappThemingTypographyDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation
import UIKit
import SwiftUI

/// Manages typography tokens, combining font and size. Provides full control over how text styles are applied in the app.
public typealias SnappThemingTypographyDeclarations = SnappThemingDeclarations<SnappThemingTypographyRepresentation, SnappThemingTypographyConfiguration>

public struct SnappThemingTypographyConfiguration {
    let fallbackFontSize: CGFloat
    let fonts: SnappThemingFontDeclarations
    let metrics: SnappThemingMetricDeclarations
}

public struct SnappThemingTypographyResolver: Sendable {
    public let uiFont: UIFont
    public let font: Font

    init(_ resolver: SnappThemingFontResolver, fontSize: CGFloat) {
        self.uiFont = resolver.uiFont(size: fontSize)
        self.font = resolver.font(size: fontSize)
    }
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingTypographyRepresentation, Configuration == SnappThemingTypographyConfiguration {
    public init(
        cache: [String: SnappThemingToken<SnappThemingTypographyRepresentation>]?,
        configuration: SnappThemingParserConfiguration,
        fonts: SnappThemingFontDeclarations,
        metrics: SnappThemingMetricDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .typography,
            configuration: .init(
                fallbackFontSize: configuration.fallbackTypographyFontSize,
                fonts: fonts,
                metrics: metrics
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingTypographyResolver {
        guard
            let representation: SnappThemingTypographyRepresentation = self[dynamicMember: keyPath],
            let font = configuration.fonts.resolver.resolve(representation.font),
            let fontSize = configuration.metrics.resolver.resolve(representation.fontSize)
        else {
            return .init(.system, fontSize: configuration.fallbackFontSize)
        }
        return .init(font.resolver, fontSize: fontSize.cgFloat)
    }

    public subscript(dynamicMember keyPath: String) -> UIFont {
        let resolver: SnappThemingTypographyResolver = self[dynamicMember: keyPath]
        return resolver.uiFont
    }

    public subscript(dynamicMember keyPath: String) -> Font {
        let resolver: SnappThemingTypographyResolver = self[dynamicMember: keyPath]
        return resolver.font
    }
}
