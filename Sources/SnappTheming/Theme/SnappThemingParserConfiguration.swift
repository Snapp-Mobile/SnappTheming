//
//  SnappThemingParserConfiguration.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 23.11.24.
//

import Foundation
import SwiftUI

public enum SnappThemingColorFormat: Sendable {
    case argb, rgba
}

public struct SnappThemingParserConfiguration: Sendable {
    public let colorFormat: SnappThemingColorFormat
    public let encodeFonts: Bool
    public let encodeImages: Bool
    public let fallbackButtonStyle: SnappThemingButtonStyleResolver
    public let fallbackColor: Color
    public let fallbackImage: Image
    public let fallbackMetric: CGFloat
    public let fallbackInteractiveColor: SnappThemingInteractiveColor
    public let fallbackTypographyFontSize: CGFloat
    public let themeCacheRootURL: URL?
    public let themeName: String

    public init(
        colorFormat: SnappThemingColorFormat = .rgba,
        encodeFonts: Bool = false,
        encodeImages: Bool = false,
        fallbackButtonStyle: SnappThemingButtonStyleResolver = .empty(),
        fallbackColor: Color = .clear,
        fallbackImage: Image = .init(systemName: "square"),
        fallbackInteractiveColor: SnappThemingInteractiveColor = .clear,
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

public extension SnappThemingParserConfiguration {
    static let `default`: SnappThemingParserConfiguration = .init()
}
