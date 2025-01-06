//
//  SAThemingParserConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 23.11.24.
//

import Foundation
import SwiftUI

public enum SAThemingColorFormat: Sendable {
    case argb, rgba
}

public struct SAThemingParserConfiguration: Sendable {
    public let colorFormat: SAThemingColorFormat
    public let encodeFonts: Bool
    public let encodeImages: Bool
    public let fallbackButtonStyle: SAThemingButtonStyleResolver
    public let fallbackColor: Color
    public let fallbackImage: Image
    public let fallbackMetric: CGFloat
    public let fallbackInteractiveColor: SAThemingInteractiveColor
    public let fallbackTypographyFontSize: CGFloat
    public let themeCacheRootURL: URL?
    public let themeName: String

    public init(
        colorFormat: SAThemingColorFormat = .rgba,
        encodeFonts: Bool = false,
        encodeImages: Bool = false,
        fallbackButtonStyle: SAThemingButtonStyleResolver = .empty(),
        fallbackColor: Color = .clear,
        fallbackImage: Image = .init(systemName: "square"),
        fallbackInteractiveColor: SAThemingInteractiveColor = .clear,
        fallbackMetric: CGFloat = 0.0,
        fallbackTypographySize: CGFloat = 0.0,
        themeCacheRootURL: URL? = nil,
        themeName: String = "default"
    ) {
        self.colorFormat = colorFormat
        self.encodeFonts = encodeFonts
        self.encodeImages = encodeImages
        self.fallbackButtonStyle = fallbackButtonStyle
        self.fallbackColor = fallbackColor
        self.fallbackImage = fallbackImage
        self.fallbackInteractiveColor = fallbackInteractiveColor
        self.fallbackMetric = fallbackMetric
        self.fallbackTypographyFontSize = fallbackTypographySize
        self.themeCacheRootURL = themeCacheRootURL
        self.themeName = themeName
    }
}

public extension SAThemingParserConfiguration {
    static let `default`: SAThemingParserConfiguration = .init()
}
