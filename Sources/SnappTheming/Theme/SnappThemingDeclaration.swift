//
//  SnappThemingDeclaration.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//
import Foundation
import OSLog

public struct SnappThemingDeclaration: Codable, SnappThemingOutput {
    public let images: SnappThemingImageDeclarations
    public let colors: SnappThemingColorDeclarations
    public let interactiveColors: SnappThemingInteractiveColorDeclarations
    public let metrics: SnappThemingMetricDeclarations
    public let fonts: SnappThemingFontDeclarations
    public let typography: SnappThemingTypographyDeclarations
    public let buttonStyles: SnappThemingButtonStyleDeclarations
    public let shapeStyle: SnappThemingShapeStyleDeclarations
    public let shapes: SnappThemingButtonStyleShapeDeclarations
    public let segmentControlStyle: SnappThemingSegmentControlStyleDeclarations
    public let sliderStyle: SnappThemingSliderStyleDeclarations
    public let toggleStyle: SnappThemingToggleStyleDeclarations

    public let fontInformations: [SnappThemingFontInformation]

    public enum CodingKeys: String, CodingKey {
        case images, colors, metrics, fonts, typography, shapeStyle
        case buttonDeclarations, interactiveColors, shapes
        case segmentControlStyle, sliderStyle, toggleStyle
    }

    public static var themeParserConfigurationUserInfoKey: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "themeParserConfiguration")!
    }

    public init(
        imageCache: [String: SnappThemingToken<SnappThemingDataURI>]? = nil,
        colorCache: [String: SnappThemingToken<SnappThemingColorRepresentation>]? = nil,
        metricsCache: [String: SnappThemingToken<Double>]? = nil,
        fontsCache: [String: SnappThemingToken<SnappThemingFontInformation>]? = nil,
        typographyCache: [String: SnappThemingToken<SnappThemingTypographyRepresentation>]? = nil,
        interactiveColorsCache: [String: SnappThemingToken<SnappThemingInteractiveColorInformation>]? = nil,
        buttonConfigurations: [String: SnappThemingToken<SnappThemingButtonStyleRepresentation>]? = nil,
        shapeInformation: [String: SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>]? = nil,
        shapeStyleCache: [String: SnappThemingToken<SnappThemingShapeStyleRepresentation>]? = nil,
        segmentControlStyleCache: [String: SnappThemingToken<SnappThemingSegmentControlStyleRepresentation>]? = nil,
        sliderStyleCache: [String: SnappThemingToken<SnappThemingSliderStyleRepresentation>]? = nil,
        toggleStyleCache: [String: SnappThemingToken<SnappThemingToggleStyleRepresentation>]? = nil,
        using parserConfiguration: SnappThemingParserConfiguration = .default
    ) {
        self.images = .init(cache: imageCache, configuration: parserConfiguration)
        self.colors = .init(cache: colorCache, configuration: parserConfiguration)
        self.interactiveColors = .init(cache: interactiveColorsCache, configuration: parserConfiguration)
        self.shapeStyle = .init(cache: shapeStyleCache, configuration: parserConfiguration)
        self.shapes = .init(cache: shapeInformation, configuration: parserConfiguration)
        self.metrics = .init(cache: metricsCache, configuration: parserConfiguration)
        self.fonts = .init(cache: fontsCache, configuration: parserConfiguration)
        self.typography = .init(cache: typographyCache, configuration: parserConfiguration, fonts: fonts, metrics: metrics)

        // TODO: Think about the proper way of collecting fonts...
        let baseFonts = fontsCache.map(\.values).map(Array.init) ?? []
        let typographyFonts = typographyCache.map(\.values)?.compactMap(typography.resolver.resolve(_:)).map(\.font) ?? []
        self.fontInformations = (baseFonts + typographyFonts).compactMap(\.value)

        self.buttonStyles = .init(cache: buttonConfigurations, configuration: parserConfiguration, metrics: metrics, fonts: fonts, colors: colors, shapes: shapes, typographies: typography, interactiveColors: interactiveColors)

        self.segmentControlStyle = .init(cache: segmentControlStyleCache, configuration: parserConfiguration, metrics: metrics, colors: colors, shapes: shapes, buttonStyles: buttonStyles, fonts: fonts, typographies: typography, interactiveColors: interactiveColors)

        self.sliderStyle = .init(cache: sliderStyleCache, configuration: parserConfiguration, metrics: metrics, colors: colors, fonts: fonts, typographies: typography)

        self.toggleStyle = .init(cache: toggleStyleCache, configuration: parserConfiguration, colors: colors)
    }

    public init(from decoder: any Decoder) throws {
        do {
            let parserConfiguration = decoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SnappThemingParserConfiguration ?? .default
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let imageCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingDataURI>].self, forKey: .images)
            let colorCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingColorRepresentation>].self, forKey: .colors)
            let metricsCache = try container.decodeIfPresent([String: SnappThemingToken<Double>].self, forKey: .metrics)
            let fontsCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingFontInformation>].self, forKey: .fonts)
            let typographyCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingTypographyRepresentation>].self, forKey: .typography)
            let interactiveColorsCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingInteractiveColorInformation>].self, forKey: .interactiveColors)
            let buttonConfigurations = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingButtonStyleRepresentation>].self, forKey: .buttonDeclarations)
            let shapeInformation = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>].self, forKey: .shapes)
            let shapeStyleCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingShapeStyleRepresentation>].self, forKey: .shapeStyle)
            let segmentControlStyleCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingSegmentControlStyleRepresentation>].self, forKey: .segmentControlStyle)
            let sliderStyleCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingSliderStyleRepresentation>].self, forKey: .sliderStyle)
            let toggleStyleCache = try container.decodeIfPresent([String: SnappThemingToken<SnappThemingToggleStyleRepresentation>].self, forKey: .toggleStyle)

            os_log("✅ Successfully decoded all declarations.")

            self.init(imageCache: imageCache,
                      colorCache: colorCache,
                      metricsCache: metricsCache,
                      fontsCache: fontsCache,
                      typographyCache: typographyCache,
                      interactiveColorsCache: interactiveColorsCache,
                      buttonConfigurations: buttonConfigurations,
                      shapeInformation: shapeInformation,
                      shapeStyleCache: shapeStyleCache,
                      segmentControlStyleCache: segmentControlStyleCache,
                      sliderStyleCache: sliderStyleCache,
                      toggleStyleCache: toggleStyleCache,
                      using: parserConfiguration)
        } catch {
            error.log()
            throw error
        }
    }

    public func encode(to encoder: any Encoder) throws {
        let parserConfiguration = encoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SnappThemingParserConfiguration ?? .default
        var container = encoder.container(keyedBy: CodingKeys.self)
        if parserConfiguration.encodeImages {
            try container.encode(images.cache, forKey: .images)
        }
        try container.encode(colors.cache, forKey: .colors)
        try container.encode(metrics.cache, forKey: .metrics)
        if parserConfiguration.encodeFonts {
            try container.encode(fonts.cache, forKey: .fonts)
        }
    }
}

extension SnappThemingDeclaration {
    public func override(
        with other: SnappThemingDeclaration,
        using configuration: SnappThemingParserConfiguration = .default
    ) -> SnappThemingDeclaration {
        SnappThemingDeclaration(imageCache: images.cache.override(other.images.cache),
                             colorCache: colors.cache.override(other.colors.cache),
                             metricsCache: metrics.cache.override(other.metrics.cache),
                             fontsCache: fonts.cache.override(other.fonts.cache),
                             typographyCache: typography.cache.override(other.typography.cache),
                             interactiveColorsCache: interactiveColors.cache.override(other.interactiveColors.cache),
                             buttonConfigurations: buttonStyles.cache.override(other.buttonStyles.cache),
                             shapeInformation: shapes.cache.override(other.shapes.cache),
                             shapeStyleCache: shapeStyle.cache.override(other.shapeStyle.cache),
                             segmentControlStyleCache: segmentControlStyle.cache.override(other.segmentControlStyle.cache),
                             sliderStyleCache: sliderStyle.cache.override(other.sliderStyle.cache),
                             toggleStyleCache: toggleStyle.cache.override(other.toggleStyle.cache),
                             using: configuration)
    }
}

fileprivate extension Dictionary {
    func override(_ other: Self) -> Self {
        merging(other, uniquingKeysWith: { _, overridden in overridden })
    }
}
