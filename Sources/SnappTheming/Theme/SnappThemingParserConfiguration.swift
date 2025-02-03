//
//  SnappThemingParserConfiguration.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 23.11.24.
//

import Foundation
import SwiftUI

/// Enum representing the supported color formats for Snapp theming.
public enum SnappThemingColorFormat: Sendable {
    /// ARGB format (Alpha, Red, Green, Blue). Used in systems where alpha (opacity) comes first.
    case argb

    /// RGBA format (Red, Green, Blue, Alpha). Common in most modern color systems, where alpha (opacity) comes last.
    case rgba
}

/// A struct that holds the configuration for the overall theming system.
/// This includes various fallback values, encoding settings, and theme-specific configurations for colors, fonts, images, and more.
public struct SnappThemingParserConfiguration: Sendable {
    /// The color format used in the theme (e.g., ARGB, RGBA).
    public let colorFormat: SnappThemingColorFormat

    /// Whether fonts should be encoded in the theme.
    public let encodeFonts: Bool

    /// Whether images should be encoded in the theme.
    public let encodeImages: Bool

    /// The fallback button style to apply when no specific button style is defined.
    public let fallbackButtonStyle: SnappThemingButtonStyleResolver

    /// The fallback color to use when no specific color is defined in the theme.
    public let fallbackColor: Color

    /// The fallback image to use when no specific image is provided.
    public let fallbackImage: Image

    public let imageManager: SnappThemingImageManager?

    /// The fallback metric (e.g., size or margin) to use when no specific metric is defined.
    public let fallbackMetric: CGFloat

    /// The fallback interactive color to use when no specific interactive color is provided.
    public let fallbackInteractiveColor: SnappThemingInteractiveColor

    /// The fallback typography font size to use when no specific typography size is defined.
    public let fallbackTypographyFontSize: CGFloat

    /// The URL for the theme cache root, used to store cached theme data.
    public let themeCacheRootURL: URL?

    /// The name of the theme, used to identify different themes.
    public let themeName: String

    /// The fallback lottie animation data to apply when no specific data for lottie animation provided.
    public let fallbackLottieAnimationData: Data

    public let fallbackGradientAngle: Angle

    public let fallbackGradientUnitPoint: UnitPoint

    public let fallbackGradientRadius: Double

    /// Initializes a new configuration with optional values. Defaults are provided for each property.
    public init(
        colorFormat: SnappThemingColorFormat = .rgba,
        encodeFonts: Bool = false,
        encodeImages: Bool = false,
        fallbackButtonStyle: SnappThemingButtonStyleResolver = .empty(),
        fallbackColor: Color = .clear,
        fallbackImage: Image = .init(systemName: "square"),
        imageManager: SnappThemingImageManager? = nil,
        fallbackInteractiveColor: SnappThemingInteractiveColor = .clear,
        fallbackMetric: CGFloat = 0.0,
        fallbackTypographySize: CGFloat = 0.0,
        themeCacheRootURL: URL? = nil,
        themeName: String = "default",
        fallbackLottieAnimationData: Data = Data(),
        fallbackGradientAngle: Angle = Angle(degrees: 0.0),
        fallbackGradientUnitPoint: UnitPoint = .center,
        fallbackGradientRadius: Double = 0
    ) {
        self.colorFormat = colorFormat
        self.encodeFonts = encodeFonts
        self.encodeImages = encodeImages
        self.fallbackButtonStyle = fallbackButtonStyle
        self.fallbackColor = fallbackColor
        self.fallbackImage = fallbackImage
        self.imageManager = imageManager
        self.fallbackInteractiveColor = fallbackInteractiveColor
        self.fallbackMetric = fallbackMetric
        self.fallbackTypographyFontSize = fallbackTypographySize
        self.themeCacheRootURL = themeCacheRootURL
        self.themeName = themeName
        self.fallbackLottieAnimationData = fallbackLottieAnimationData
        self.fallbackGradientAngle = fallbackGradientAngle
        self.fallbackGradientUnitPoint = fallbackGradientUnitPoint
        self.fallbackGradientRadius = fallbackGradientRadius
    }
}

extension SnappThemingParserConfiguration {
    /// A default configuration instance with pre-defined values.
    public static let `default`: SnappThemingParserConfiguration = .init()
}
