//
//  SnappThemingDeclaration.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import OSLog

/// A model representing a comprehensive set of theming declarations for an application.
public struct SnappThemingDeclaration: Codable, SnappThemingOutput {
    // MARK: - Public Properties

    /// Image declarations.
    public let images: SnappThemingImageDeclarations
    /// Color declarations.
    public let colors: SnappThemingColorDeclarations
    /// Interactive color declarations.
    public let interactiveColors: SnappThemingInteractiveColorDeclarations
    /// Metric declarations.
    public let metrics: SnappThemingMetricDeclarations
    /// Font declarations.
    public let fonts: SnappThemingFontDeclarations
    /// Typography declarations.
    public let typography: SnappThemingTypographyDeclarations
    /// Button style declarations.
    public let buttonStyles: SnappThemingButtonStyleDeclarations
    /// Shape style declarations.
    public let gradients: SnappThemingGradientDeclarations
    /// Shape declarations.
    public let shapes: SnappThemingShapeDeclarations
    /// Segment control style declarations.
    public let segmentControlStyle: SnappThemingSegmentControlStyleDeclarations
    /// Slider style declarations.
    public let sliderStyle: SnappThemingSliderStyleDeclarations
    /// Toggle style declarations.
    public let toggleStyle: SnappThemingToggleStyleDeclarations
    /// Information about fonts used in the theme.
    public let fontInformation: [SnappThemingFontInformation]
    /// Animation declarations.
    public let animations: SnappThemingAnimationDeclarations

    public enum CodingKeys: String, CodingKey {
        case images, colors, metrics, fonts, typography, gradients
        case buttonStyles, interactiveColors, shapes
        case segmentControlStyle, sliderStyle, toggleStyle
        case animations
    }

    /// Key used to pass parser configuration through `JSONDecoder` or `JSONEncoder` user info.
    public static var themeParserConfigurationUserInfoKey: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "themeParserConfiguration")!
    }

    // MARK: - Initializers

    /// Initializes a new instance of `SnappThemingDeclaration` with optional caches and a parser configuration.
    public init(
        imageCache: [String: SnappThemingToken<SnappThemingDataURI>]? = nil,
        colorCache: [String: SnappThemingToken<SnappThemingColorRepresentation>]? = nil,
        metricsCache: [String: SnappThemingToken<Double>]? = nil,
        fontsCache: [String: SnappThemingToken<SnappThemingFontInformation>]? = nil,
        typographyCache: [String: SnappThemingToken<SnappThemingTypographyRepresentation>]? = nil,
        interactiveColorsCache: [String: SnappThemingToken<SnappThemingInteractiveColorInformation>]? = nil,
        buttonStylesCache: [String: SnappThemingToken<SnappThemingButtonStyleRepresentation>]? = nil,
        shapeInformation: [String: SnappThemingToken<SnappThemingShapeRepresentation>]? = nil,
        gradientsCache: [String: SnappThemingToken<SnappThemingGradientRepresentation>]? = nil,
        segmentControlStyleCache: [String: SnappThemingToken<SnappThemingSegmentControlStyleRepresentation>]? = nil,
        sliderStyleCache: [String: SnappThemingToken<SnappThemingSliderStyleRepresentation>]? = nil,
        toggleStyleCache: [String: SnappThemingToken<SnappThemingToggleStyleRepresentation>]? = nil,
        animationCache: [String: SnappThemingToken<SnappThemingAnimationRepresentation>]? = nil,
        using parserConfiguration: SnappThemingParserConfiguration = .default
    ) {
        self.images = .init(cache: imageCache, configuration: parserConfiguration)
        self.colors = .init(cache: colorCache, configuration: parserConfiguration)
        self.interactiveColors = .init(cache: interactiveColorsCache, configuration: parserConfiguration)
        self.metrics = .init(cache: metricsCache, configuration: parserConfiguration)
        self.fonts = .init(cache: fontsCache, configuration: parserConfiguration)
        self.typography = .init(
            cache: typographyCache, configuration: parserConfiguration, fonts: fonts, metrics: metrics)

        // TODO: Think about the proper way of collecting fonts...
        let baseFonts = fontsCache.map(\.values).map(Array.init) ?? []
        let typographyFonts =
            typographyCache.map(\.values)?.compactMap(typography.resolver.resolve(_:)).map(\.font) ?? []
        self.fontInformation = (baseFonts + typographyFonts).compactMap(\.value)

        self.shapes = SnappThemingShapeDeclarations(
            cache: shapeInformation,
            metrics: metrics,
            configuration: parserConfiguration
        )

        self.gradients = SnappThemingGradientDeclarations(
            cache: gradientsCache,
            metrics: metrics,
            colors: colors,
            configuration: parserConfiguration
        )
        self.buttonStyles = .init(
            cache: buttonStylesCache,
            configuration: parserConfiguration,
            metrics: metrics,
            fonts: fonts,
            colors: colors,
            shapes: shapes,
            typographies: typography,
            interactiveColors: interactiveColors
        )

        self.segmentControlStyle = .init(
            cache: segmentControlStyleCache,
            configuration: parserConfiguration,
            metrics: metrics,
            colors: colors,
            shapes: shapes,
            buttonStyles: buttonStyles,
            fonts: fonts,
            typographies: typography,
            interactiveColors: interactiveColors
        )

        self.sliderStyle = .init(
            cache: sliderStyleCache,
            configuration: parserConfiguration,
            metrics: metrics,
            colors: colors,
            fonts: fonts,
            typographies: typography
        )

        self.toggleStyle = .init(
            cache: toggleStyleCache,
            configuration: parserConfiguration,
            colors: colors
        )

        self.animations = .init(
            cache: animationCache,
            configuration: parserConfiguration
        )
    }

    public init(from decoder: any Decoder) throws {
        do {
            let parserConfiguration =
                decoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SnappThemingParserConfiguration
                ?? .default
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let imageCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingDataURI>].self,
                forKey: .images
            )
            let colorCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingColorRepresentation>].self,
                forKey: .colors
            )
            let metricsCache = try container.decodeIfPresent(
                [String: SnappThemingToken<Double>].self,
                forKey: .metrics
            )
            let fontsCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingFontInformation>].self, forKey: .fonts)
            let typographyCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingTypographyRepresentation>].self,
                forKey: .typography
            )
            let interactiveColorsCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingInteractiveColorInformation>].self,
                forKey: .interactiveColors
            )
            let buttonStylesCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingButtonStyleRepresentation>].self,
                forKey: .buttonStyles
            )
            let shapeInformation = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingShapeRepresentation>].self,
                forKey: .shapes
            )
            let gradientsCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingGradientRepresentation>].self,
                forKey: .gradients
            )
            let segmentControlStyleCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingSegmentControlStyleRepresentation>].self,
                forKey: .segmentControlStyle
            )
            let sliderStyleCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingSliderStyleRepresentation>].self,
                forKey: .sliderStyle
            )
            let toggleStyleCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingToggleStyleRepresentation>].self,
                forKey: .toggleStyle
            )
            let animationCache = try container.decodeIfPresent(
                [String: SnappThemingToken<SnappThemingAnimationRepresentation>].self,
                forKey: .animations
            )

            self.init(
                imageCache: imageCache,
                colorCache: colorCache,
                metricsCache: metricsCache,
                fontsCache: fontsCache,
                typographyCache: typographyCache,
                interactiveColorsCache: interactiveColorsCache,
                buttonStylesCache: buttonStylesCache,
                shapeInformation: shapeInformation,
                gradientsCache: gradientsCache,
                segmentControlStyleCache: segmentControlStyleCache,
                sliderStyleCache: sliderStyleCache,
                toggleStyleCache: toggleStyleCache,
                animationCache: animationCache,
                using: parserConfiguration)
        } catch {
            error.log()
            throw error
        }
    }

    public func encode(to encoder: any Encoder) throws {
        let parserConfiguration =
            encoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SnappThemingParserConfiguration ?? .default
        var container = encoder.container(keyedBy: CodingKeys.self)
        if parserConfiguration.encodeImages {
            try container.encode(images.cache, forKey: .images)
        }
        if !colors.cache.isEmpty {
            try container.encode(colors.cache, forKey: .colors)
        }
        if !metrics.cache.isEmpty {
            try container.encode(metrics.cache, forKey: .metrics)
        }
        if parserConfiguration.encodeFonts {
            try container.encode(fonts.cache, forKey: .fonts)
        }
        if !typography.cache.isEmpty {
            try container.encode(typography.cache, forKey: .typography)

        }
        if !gradients.cache.isEmpty {
            try container.encode(gradients.cache, forKey: .gradients)
        }
        if !buttonStyles.cache.isEmpty {
            try container.encode(buttonStyles.cache, forKey: .buttonStyles)
        }
        if !interactiveColors.cache.isEmpty {
            try container.encode(interactiveColors.cache, forKey: .interactiveColors)
        }
        if !shapes.cache.isEmpty {
            try container.encode(shapes.cache, forKey: .shapes)
        }
        if !segmentControlStyle.cache.isEmpty {
            try container.encode(segmentControlStyle.cache, forKey: .segmentControlStyle)
        }
        if !sliderStyle.cache.isEmpty {
            try container.encode(sliderStyle.cache, forKey: .sliderStyle)
        }
        if !toggleStyle.cache.isEmpty {
            try container.encode(toggleStyle.cache, forKey: .toggleStyle)
        }
        if !animations.cache.isEmpty {
            try container.encode(animations.cache, forKey: .animations)
        }
    }
}

extension SnappThemingDeclaration {
    public func override(
        with other: SnappThemingDeclaration,
        using configuration: SnappThemingParserConfiguration = .default
    ) -> SnappThemingDeclaration {
        SnappThemingDeclaration(
            imageCache: images.cache.override(other.images.cache),
            colorCache: colors.cache.override(other.colors.cache),
            metricsCache: metrics.cache.override(other.metrics.cache),
            fontsCache: fonts.cache.override(other.fonts.cache),
            typographyCache: typography.cache.override(other.typography.cache),
            interactiveColorsCache: interactiveColors.cache.override(other.interactiveColors.cache),
            buttonStylesCache: buttonStyles.cache.override(other.buttonStyles.cache),
            shapeInformation: shapes.cache.override(other.shapes.cache),
            gradientsCache: gradients.cache.override(other.gradients.cache),
            segmentControlStyleCache: segmentControlStyle.cache.override(other.segmentControlStyle.cache),
            sliderStyleCache: sliderStyle.cache.override(other.sliderStyle.cache),
            toggleStyleCache: toggleStyle.cache.override(other.toggleStyle.cache),
            using: configuration)
    }
}

extension Dictionary {
    fileprivate func override(_ other: Self) -> Self {
        merging(other, uniquingKeysWith: { _, overridden in overridden })
    }
}
