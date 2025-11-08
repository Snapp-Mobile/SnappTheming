//
//  SliderStyleTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 28.01.2025.
//

import SwiftUI
import Testing

@testable import SnappTheming

#if canImport(UIKit)
    import UIKit
#endif

@Suite
struct SliderStyleTests {
    @Test(arguments: [
        """
        {
            "colors": {
                "appGreen": "#ABCD12"
            },
            "typography": {
                "textLarge": {
                    "font": \(MockJSONData.font("Roboto-Regular")),
                    "fontSize": 34
                },
                "textSmall": {
                    "font": \(MockJSONData.font("Roboto-Regular")),
                    "fontSize": 22
                } 
            },
            "sliderStyle": {
                "primary": {
                    "minimumTrackTintColor": "$colors/appGreen",
                    "minimumTrackTintColorSecondary": "#616161",
                    "maximumTrackTintColor": "#FFFFFF0F",
                    "headerTypography": "$typography/textLarge",
                    "tickMarkTypography": "$typography/textSmall",
                    "tickMarkColor": "#FFFFFF80"
                }
            }
        }
        """,
        """
        {
            "sliderStyle": {
                "primary": {
                    "minimumTrackTintColor": "#ABCD12",
                    "minimumTrackTintColorSecondary": "#616161",
                    "maximumTrackTintColor": "#FFFFFF0F",
                    "headerTypography": {
                        "font": \(MockJSONData.font("Roboto-Regular")),
                        "fontSize": 34
                    },
                    "tickMarkTypography": {
                        "font": \(MockJSONData.font("Roboto-Regular")),
                        "fontSize": 22
                    },
                    "tickMarkColor": "#FFFFFF80"
                }
            }
        }
        """,
    ])
    func parseSliderStyleWithSuccess(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(from: json, using: configuration)
        try compareEncoded(declaration, and: json)
        let _ = try #require(declaration.sliderStyle.cache["primary"]?.value)
        let sliderStyle: SnappThemingSliderStyleResolver = declaration
            .sliderStyle.primary
        let sliderStyleFallbackConfiguration = declaration.sliderStyle
            .configuration

        #expect(declaration.sliderStyle.cache.count == 1)

        let minimumTrackTintColor: Color = sliderStyle.minimumTrackTintColor
        #expect(
            minimumTrackTintColor
                != sliderStyleFallbackConfiguration
                .fallbackMinimumTrackTintColor
        )
        #expect(minimumTrackTintColor == Color(hex: "#ABCD12"))

        let minimumTrackTintColorSecondary: Color = sliderStyle
            .minimumTrackTintColorSecondary
        #expect(
            minimumTrackTintColorSecondary
                != sliderStyleFallbackConfiguration
                .fallbackMinimumTrackTintColor
        )
        #expect(minimumTrackTintColorSecondary == Color(hex: "#616161"))

        let maximumTrackTintColor: Color = sliderStyle.maximumTrackTintColor
        #expect(
            maximumTrackTintColor
                != sliderStyleFallbackConfiguration
                .fallbackMaximumTrackTintColor
        )
        #expect(maximumTrackTintColor == Color(hex: "#FFFFFF0F"))

        let tickMarkColor: Color = sliderStyle.tickMarkColor
        #expect(
            tickMarkColor
                != sliderStyleFallbackConfiguration.fallbackTickMarkColor
        )
        #expect(tickMarkColor == Color(hex: "#FFFFFF80"))

        #if canImport(UIKit)
            // Header Typography
            let headerTypography = sliderStyle.headerTypography
            #expect(headerTypography.uiFont != nil)
            #expect(
                headerTypography.uiFont.pointSize
                    != sliderStyleFallbackConfiguration.fallbackFontSize,
                "Parsed typography font size should not match the fallback one."
            )
            #expect(
                headerTypography.uiFont.pointSize == 34.0,
                "Header typography font size should be 34."
            )
            // Tick Mark Typography
            let tickMarkTypography = sliderStyle.tickMarkTypography
            #expect(tickMarkTypography.uiFont != nil)
            #expect(
                tickMarkTypography.uiFont.pointSize
                    != sliderStyleFallbackConfiguration.fallbackFontSize,
                "Parsed typography font size should not match the fallback one."
            )
            #expect(
                tickMarkTypography.uiFont.pointSize == 22.0,
                "Header typography font size should be 22."
            )
        #endif
    }

    @Test(arguments: [
        """
        {
            "sliderStyle": {
                "primary": {
                    "minimumTrackTintColor": "$colors/appGrey",
                    "minimumTrackTintColorSecondary": "$colors/appGreenSecondary",
                    "maximumTrackTintColor": "$colors/appGreen",
                    "headerTypography": "$typography/textLarge",
                    "tickMarkTypography": "$typography/textSmall",
                    "tickMarkColor": "$colors/primary"
                }
            }
        }
        """,
        """
        {
            "sliderStyle": {
                "primary": {
                    "minimumTrackTintColor": "$colors/appGreen",
                    "minimumTrackTintColorSecondary": "$color/tertiary",
                    "maximumTrackTintColor": "$colors/appGreenSecondary",
                    "headerTypography": {
                        "font": "$font/Roboto-Regular",
                        "fontSize": "$metrics/large"
                    },
                    "tickMarkTypography": {
                        "font": "$font/Roboto-Regular",
                        "fontSize": "$metrics/small"
                    },
                    "tickMarkColor": "$color/fancy"
                }
            }
        }
        """,
    ])
    func parseSliderStyleWithWrongAliases(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json,
            using: configuration
        )
        let _ = try #require(declaration.sliderStyle.cache["primary"]?.value)
        let sliderStyle: SnappThemingSliderStyleResolver = declaration
            .sliderStyle.primary
        let sliderStyleFallbackConfiguration = declaration.sliderStyle
            .configuration

        #expect(declaration.sliderStyle.cache.count == 1)

        let minimumTrackTintColor: Color = sliderStyle.minimumTrackTintColor
        #expect(
            minimumTrackTintColor
                == sliderStyleFallbackConfiguration
                .fallbackMinimumTrackTintColor
        )
        let minimumTrackTintColorSecondary: Color = sliderStyle
            .minimumTrackTintColorSecondary
        #expect(
            minimumTrackTintColorSecondary
                == sliderStyleFallbackConfiguration
                .fallbackMinimumTrackTintColor
        )
        let maximumTrackTintColor: Color = sliderStyle.maximumTrackTintColor
        #expect(
            maximumTrackTintColor
                == sliderStyleFallbackConfiguration
                .fallbackMaximumTrackTintColor
        )
        let tickMarkColor: Color = sliderStyle.tickMarkColor
        #expect(
            tickMarkColor
                == sliderStyleFallbackConfiguration.fallbackTickMarkColor
        )
        #if canImport(UIKit)
            // Header Typography
            let headerTypography = sliderStyle.headerTypography
            #expect(headerTypography.uiFont != nil)
            #expect(
                headerTypography.uiFont.pointSize
                    == sliderStyleFallbackConfiguration.fallbackFontSize,
                "Parsed typography font size should match the fallback one."
            )
            #expect(
                headerTypography.uiFont.pointSize == 0.0,
                "Header typography font size should fall to 0."
            )
            // Tick Mark Typography
            let tickMarkTypography = sliderStyle.tickMarkTypography
            #expect(tickMarkTypography.uiFont != nil)
            #expect(
                tickMarkTypography.uiFont.pointSize
                    == sliderStyleFallbackConfiguration.fallbackFontSize,
                "Parsed typography font size should match the fallback one."
            )
            #expect(
                tickMarkTypography.uiFont.pointSize == 0.0,
                "Tick Mark typography font size should fall to 0."
            )
        #endif
    }

    @Test()
    func testEmptySliderStyle() throws {
        let sliderStyle: SnappThemingSliderStyleResolver = .empty()

        let minimumTrackTintColor: Color = sliderStyle.minimumTrackTintColor
        #expect(minimumTrackTintColor == .clear)
        let minimumTrackTintColorSecondary: Color = sliderStyle
            .minimumTrackTintColorSecondary
        #expect(minimumTrackTintColorSecondary == .clear)
        let maximumTrackTintColor: Color = sliderStyle.maximumTrackTintColor
        #expect(maximumTrackTintColor == .clear)
        let tickMarkColor: Color = sliderStyle.tickMarkColor
        #expect(tickMarkColor == .clear)

        #if canImport(UIKit)
            let headerTypography = sliderStyle.headerTypography
            #expect(headerTypography.uiFont != nil)
            #expect(
                headerTypography.uiFont.pointSize == 32,
                "Empty slider style should fall back to the default typography font size of 32."
            )
            // Tick Mark Typography
            let tickMarkTypography = sliderStyle.tickMarkTypography
            #expect(tickMarkTypography.font != nil)
            #expect(tickMarkTypography.uiFont != nil)
            #expect(
                tickMarkTypography.uiFont.pointSize == 32,
                "Tick mark typography font size should fall back to the default typography font size of 32."
            )
        #endif
    }
}
