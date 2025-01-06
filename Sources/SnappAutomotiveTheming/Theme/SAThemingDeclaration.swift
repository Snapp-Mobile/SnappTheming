//
//  SAThemeDeclaration.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 21.11.24.
//
import Foundation
import OSLog

public struct SAThemingDeclaration: Codable, SAThemingOutput {
    public let images: SAThemingImageDeclarations
    public let colors: SAThemingColorDeclarations
    public let metrics: SAThemingMetricDeclarations
    public let fonts: SAThemingFontDeclarations
    public let typography: SAThemingTypographyDeclarations
    public let buttonStyles: SAThemingButtonStyleDeclarations
    public let shapeStyle: SAThemingShapeStyleDeclarations
    public let segmentControlStyle: SAThemingSegmentControlStyleDeclarations
    public let sliderStyle: SAThemingSliderStyleDeclarations
    public let toggleStyle: SAThemingToggleStyleDeclarations

    public let fontInformations: [SAThemingFontInformation]

    enum CodingKeys: String, CodingKey {
        case images, colors, metrics, fonts, typography, shapeStyle
        case buttonDeclarations, interactiveColors, shapes
        case segmentControlStyle, sliderStyle, toggleStyle
    }

    public static var themeParserConfigurationUserInfoKey: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "themeParserConfiguration")!
    }

    public init(from decoder: any Decoder) throws {
        do {
            let parserConfiguration = decoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SAThemingParserConfiguration ?? .default
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let imageCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingDataURI>].self, forKey: .images)
            let colorCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingColorRepresentation>].self, forKey: .colors)
            let metricsCache = try container.decodeIfPresent([String: SAThemingToken<Double>].self, forKey: .metrics)
            let fontsCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingFontInformation>].self, forKey: .fonts)
            let typographyCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingTypographyRepresentation>].self, forKey: .typography)
            let interactiveColorsCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingInteractiveColorInformation>].self, forKey: .interactiveColors)
            let buttonConfigurations = try container.decodeIfPresent([String: SAThemingToken<SAThemingButtonStyleRepresentation>].self, forKey: .buttonDeclarations)
            let shapeInformation = try container.decodeIfPresent([String: SAThemingToken<SAThemingButtonStyleShapeRepresentation>].self, forKey: .shapes)
            let shapeStyleCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingShapeStyleRepresentation>].self, forKey: .shapeStyle)
            let segmentControlStyleCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingSegmentControlStyleRepresentation>].self, forKey: .segmentControlStyle)
            let sliderStyleCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingSliderStyleRepresentation>].self, forKey: .sliderStyle)
            let toggleStyleCache = try container.decodeIfPresent([String: SAThemingToken<SAThemingToggleStyleRepresentation>].self, forKey: .toggleStyle)

            self.images = .init(cache: imageCache, configuration: parserConfiguration)
            self.colors = .init(cache: colorCache, configuration: parserConfiguration)
            self.shapeStyle = .init(cache: shapeStyleCache, configuration: parserConfiguration)
            self.metrics = .init(cache: metricsCache, configuration: parserConfiguration)
            self.fonts = .init(cache: fontsCache, configuration: parserConfiguration)
            self.typography = .init(cache: typographyCache, configuration: parserConfiguration, fonts: fonts, metrics: metrics)

            // TODO: Think about the proper way of collecting fonts...
            let baseFonts = fontsCache.map(\.values).map(Array.init) ?? []
            let typographyFonts = typographyCache.map(\.values)?.compactMap(typography.resolver.resolve(_:)).map(\.font) ?? []
            self.fontInformations = (baseFonts + typographyFonts).compactMap(\.value)

            let interactiveColors: SAThemingInteractiveColorDeclarations = .init(cache: interactiveColorsCache, configuration: parserConfiguration)
            let shapes: SAThemingButtonStyleShapeDeclarations = .init(cache: shapeInformation, configuration: parserConfiguration)

            self.buttonStyles = .init(cache: buttonConfigurations, configuration: parserConfiguration, metrics: metrics, fonts: fonts, colors: colors, shapes: shapes, typographies: typography, interactiveColors: interactiveColors)

            self.segmentControlStyle = .init(cache: segmentControlStyleCache, configuration: parserConfiguration, metrics: metrics, colors: colors, shapes: shapes, buttonStyles: buttonStyles, fonts: fonts, typographies: typography, interactiveColors: interactiveColors)

            self.sliderStyle = .init(cache: sliderStyleCache, configuration: parserConfiguration, metrics: metrics, colors: colors, fonts: fonts, typographies: typography)

            self.toggleStyle = .init(cache: toggleStyleCache, configuration: parserConfiguration, colors: colors)

            os_log("✅ Successfully decoded all declarations.")
        } catch {
            error.log()
            throw error
        }
    }

    public func encode(to encoder: any Encoder) throws {
        // TODO: Get rid of `resolver.baseValues`
        let parserConfiguration = encoder.userInfo[Self.themeParserConfigurationUserInfoKey] as? SAThemingParserConfiguration ?? .default
        var container = encoder.container(keyedBy: CodingKeys.self)
        if parserConfiguration.encodeImages {
            try container.encode(images.cache, forKey: .images)
        }
        try container.encode(colors.resolver.baseValues[CodingKeys.colors.rawValue], forKey: .colors)
        try container.encode(metrics.cache, forKey: .metrics)
        if parserConfiguration.encodeFonts {
            try container.encode(fonts.cache, forKey: .fonts)
        }
    }
}
