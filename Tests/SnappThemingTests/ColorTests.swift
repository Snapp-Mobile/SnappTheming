//
//  ColorTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 13.01.2025.
//

import SwiftUI
import Testing

@testable import SnappTheming

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

@Suite
struct ColorTests {
    @Test(arguments: [
        """
        {"colors": {"test": "#FFFFFF"}}
        """,
        """
        {"colors": {"test": "#000000"}}
        """,
        """
        {"colors": {"test": {"light": "#00ff00", "dark": "#0000ff"}}}
        """,
    ])
    func parseCorrectlyProvidedColor(
        _ json: String
    ) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        try compareEncoded(declaration, and: json)

        let color: Color = declaration.colors.test
        #expect(color != .clear, "Correctly provided color should not be transparent.")
        #if canImport(UIKit)
            let uiColor: UIColor = declaration.colors.test
            let light = uiColor.resolvedColor(
                with: .init(userInterfaceStyle: .light))
            let dark = uiColor.resolvedColor(
                with: .init(userInterfaceStyle: .dark))
        #elseif canImport(AppKit)
            let nsColor: NSColor = declaration.colors.test
            let light = nsColor.resolvedColor(with: .aqua)
            let dark = nsColor.resolvedColor(with: .darkAqua)
        #endif

        #expect(light != .clear, "Correctly provided light color should not be transparent.")
        #expect(dark != .clear, "Correctly provided dark color should not be transparent.")
    }

    @Test(arguments: [
        (
            """
            {"colors": {"test": "#0000AA"}}
            """, SnappThemingColorFormat.rgba
        ),
        (
            """
            {"colors": {"test": "#0011AA"}}
            """, SnappThemingColorFormat.rgba
        ),
        (
            """
            {"colors": {"test": "#AAAAAA"}}
            """, SnappThemingColorFormat.rgba
        ),
        (
            """
            {"colors": {"test": "#AAAAAA00"}}
            """, SnappThemingColorFormat.rgba
        ),
        (
            """
            {"colors": {"test": "#00A"}}
            """, SnappThemingColorFormat.rgba
        ),
        (
            """
            {"colors": {"test": "#00FFFFAA"}}
            """, SnappThemingColorFormat.argb
        ),
    ])
    func parseColorBlue(
        _ json: (String, SnappThemingColorFormat)
    ) throws {
        // "AA" -> 170
        let expectedBlue = 170
        let declaration = try SnappThemingParser.parse(from: json.0, using: .init(colorFormat: json.1))
        #if canImport(UIKit)
            let testColor: UIColor = declaration.colors.test
            let testColorUnspecified = testColor.resolvedColor(with: .init(userInterfaceStyle: .unspecified))
            let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
            let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))
            let testColorUnspecifiedBlue = try #require(testColorUnspecified.cgColor.components?[2])
            let testColorLightBlue = try #require(light.cgColor.components?[2])
            let testColorDarkBlue = try #require(dark.cgColor.components?[2])
        #elseif canImport(AppKit)
            let testColor: NSColor = declaration.colors.test
            let colors = Color(testColor).resolvedNSColors()
            let testColorUnspecifiedBlue = try #require(colors.light.cgColor.components?[2])
            let testColorLightBlue = try #require(colors.light.cgColor.components?[2])
            let testColorDarkBlue = try #require(colors.dark.cgColor.components?[2])
        #endif
        #expect(Int((testColorUnspecifiedBlue * 255).rounded()) == expectedBlue)
        #expect(Int((testColorLightBlue * 255).rounded()) == expectedBlue)
        #expect(Int((testColorDarkBlue * 255).rounded()) == expectedBlue)

    }

    @Test
    func parseColorDarkLightColor() throws {
        let json =
            """
            {
                "colors": {
                    "primary": {
                        "light": "#E94E4A",
                        "dark": "#EF6820"
                    }
                }
            }
            """
        let expectedLightBlue = 74
        let expectedDarkBlue = 32
        let declaration = try SnappThemingParser.parse(from: json)

        #if canImport(UIKit)
            let testColor: UIColor = declaration.colors.primary
            let testColorUnspecified = testColor.resolvedColor(with: .init(userInterfaceStyle: .unspecified))
            let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
            let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))

            let testColorUnspecifiedBlue = try #require(testColorUnspecified.cgColor.components?[2])
            let testColorLightBlue = try #require(light.cgColor.components?[2])
            let testColorDarkBlue = try #require(dark.cgColor.components?[2])
        #elseif canImport(AppKit)
            let testColor: NSColor = declaration.colors.primary
            let colors = Color(testColor).resolvedNSColors()
            let testColorUnspecifiedBlue = try #require(colors.light.cgColor.components?[2])
            let testColorLightBlue = try #require(colors.light.cgColor.components?[2])
            let testColorDarkBlue = try #require(colors.dark.cgColor.components?[2])
        #endif

        #expect(Int((testColorUnspecifiedBlue * 255).rounded()) == expectedLightBlue)
        #expect(Int((testColorLightBlue * 255).rounded()) == expectedLightBlue)
        #expect(Int((testColorDarkBlue * 255).rounded()) == expectedDarkBlue)

    }

    @Test
    func parseColorAliasing() throws {
        let json =
            """
            {
                "colors": {
                    "primary": {
                        "light": "#E94E4A",
                        "dark": "#EF6820"
                    },
                    "secondary": "$colors/primary"
                }
            }
            """
        let expectedLightBlue = 74
        let expectedDarkBlue = 32
        let declaration = try SnappThemingParser.parse(from: json)
        #if canImport(UIKit)
            let testColor: UIColor = declaration.colors.secondary
            let testColorUnspecified = testColor.resolvedColor(with: .init(userInterfaceStyle: .unspecified))
            let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
            let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))
            let testColorUnspecifiedBlue = try #require(testColorUnspecified.cgColor.components?[2])
            let testColorLightBlue = try #require(light.cgColor.components?[2])
            let testColorDarkBlue = try #require(dark.cgColor.components?[2])
        #elseif canImport(AppKit)
            let testColor: NSColor = declaration.colors.secondary
            let colors = Color(testColor).resolvedNSColors()
            let testColorUnspecifiedBlue = try #require(colors.light.cgColor.components?[2])
            let testColorLightBlue = try #require(colors.light.cgColor.components?[2])
            let testColorDarkBlue = try #require(colors.dark.cgColor.components?[2])
        #endif
        #expect(Int((testColorUnspecifiedBlue * 255).rounded()) == expectedLightBlue)
        #expect(Int((testColorLightBlue * 255).rounded()) == expectedLightBlue)
        #expect(Int((testColorDarkBlue * 255).rounded()) == expectedDarkBlue)
    }

    @Test
    func useFallbackColor() throws {
        let json = "{ \"colors\": { } }"

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = SnappThemingParserConfiguration.default
        let primaryColor: Color = declaration.colors.primary
        #expect(primaryColor == fallbackConfiguration.fallbackColor)
        #if canImport(UIKit)
            let primaryUIColor: UIColor = declaration.colors.primary
            #expect(primaryUIColor == fallbackConfiguration.fallbackColor.uiColor)
        #elseif canImport(AppKit)
            let primaryNSColor: NSColor = declaration.colors.primary
            #expect(primaryNSColor.isEqual(to: NSColor(fallbackConfiguration.fallbackColor)))
        #endif
    }
}
