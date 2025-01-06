//
//  SAThemingTypographyDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation
import UIKit
import SwiftUI

public typealias SAThemingTypographyDeclarations = SAThemingDeclarations<SAThemingTypographyRepresentation, SAThemingTypographyConfiguration>

public struct SAThemingTypographyConfiguration {
    let fallbackFontSize: CGFloat
    let fonts: SAThemingFontDeclarations
    let metrics: SAThemingMetricDeclarations
}

public struct SAThemingTypographyResolver: Sendable {
    public let uiFont: UIFont
    public let font: Font

    init(_ resolver: SAThemingFontResolver, fontSize: CGFloat) {
        self.uiFont = resolver.uiFont(size: fontSize)
        self.font = resolver.font(size: fontSize)
    }
}

extension SAThemingDeclarations where DeclaredValue == SAThemingTypographyRepresentation, Configuration == SAThemingTypographyConfiguration {
    public init(
        cache: [String: SAThemingToken<SAThemingTypographyRepresentation>]?,
        configuration: SAThemingParserConfiguration,
        fonts: SAThemingFontDeclarations,
        metrics: SAThemingMetricDeclarations
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

    public subscript(dynamicMember keyPath: String) -> SAThemingTypographyResolver {
        guard
            let representation: SAThemingTypographyRepresentation = self[dynamicMember: keyPath],
            let font = configuration.fonts.resolver.resolve(representation.font),
            let fontSize = configuration.metrics.resolver.resolve(representation.fontSize)
        else {
            return .init(.system, fontSize: configuration.fallbackFontSize)
        }
        return .init(font.resolver, fontSize: fontSize.cgFloat)
    }

    public subscript(dynamicMember keyPath: String) -> UIFont {
        let resolver: SAThemingTypographyResolver = self[dynamicMember: keyPath]
        return resolver.uiFont
    }

    public subscript(dynamicMember keyPath: String) -> Font {
        let resolver: SAThemingTypographyResolver = self[dynamicMember: keyPath]
        return resolver.font
    }
}
