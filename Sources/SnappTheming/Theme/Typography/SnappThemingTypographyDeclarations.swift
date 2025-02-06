//
//  SnappThemingTypographyDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
    import UIKit
#endif

public typealias SnappThemingTypographyDeclarations = SnappThemingDeclarations<
    SnappThemingTypographyRepresentation,
    SnappThemingTypographyConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingTypographyRepresentation,
    Configuration == SnappThemingTypographyConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration,
        fonts: SnappThemingFontDeclarations,
        metrics: SnappThemingMetricDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .typography,
            configuration: Configuration(
                fallbackFontSize: configuration.fallbackTypographyFontSize,
                fonts: fonts,
                metrics: metrics
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingTypographyResolver {
        guard
            let representation: DeclaredValue = self[dynamicMember: keyPath],
            let font = configuration.fonts.resolver.resolve(representation.font),
            let fontSize = configuration.metrics.resolver.resolve(representation.fontSize)
        else {
            return SnappThemingTypographyResolver(.system, fontSize: configuration.fallbackFontSize)
        }
        return SnappThemingTypographyResolver(font.resolver, fontSize: fontSize.cgFloat)
    }

    #if canImport(UIKit)
        public subscript(dynamicMember keyPath: String) -> UIFont {
            let resolver: SnappThemingTypographyResolver = self[dynamicMember: keyPath]
            return resolver.uiFont
        }
    #endif

    public subscript(dynamicMember keyPath: String) -> Font {
        let resolver: SnappThemingTypographyResolver = self[dynamicMember: keyPath]
        return resolver.font
    }
}
