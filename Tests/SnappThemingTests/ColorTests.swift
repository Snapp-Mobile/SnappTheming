//
//  ColorTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 13.01.2025.
//

@testable import SnappTheming
import Testing
import UIKit

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
    """
    ])
    func parseCorrectlyProvidedColor(
        _ json: String
    ) throws {
        let declaration = try SnappThemingParser.parse(from: json)

        let testColor: UIColor = declaration.colors.test
        let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
        let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))

        #expect(light != .clear, "Correctly provided light color should not be transparent.")
        #expect(dark != .clear, "Correctly provided dark color should not be transparent.")
    }

    @Test(arguments: [
    ("""
    {"colors": {"test": "#0000AA"}}
    """, SnappThemingColorFormat.rgba),
    ("""
    {"colors": {"test": "#0011AA"}}
    """, SnappThemingColorFormat.rgba),
    ("""
    {"colors": {"test": "#AAAAAA"}}
    """, SnappThemingColorFormat.rgba),
    ("""
    {"colors": {"test": "#AAAAAA00"}}
    """, SnappThemingColorFormat.rgba),
    ("""
    {"colors": {"test": "#00A"}}
    """, SnappThemingColorFormat.rgba),
    ("""
    {"colors": {"test": "#00FFFFAA"}}
    """, SnappThemingColorFormat.argb)
    ])
    func parseColor_blue(
        _ json: (String, SnappThemingColorFormat)
    ) throws {
        // "AA" -> 170
        let expectedBlue = 170
        let declaration = try SnappThemingParser.parse(from: json.0, using: .init(colorFormat: json.1))

        let testColor: UIColor = declaration.colors.test
        let testColorUnspecified = testColor.resolvedColor(with: .init(userInterfaceStyle: .unspecified))
        let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
        let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))

        let testColorUnspecifiedBlue = try #require(testColorUnspecified.cgColor.components?[2])
        let testColorLightBlue = try #require(light.cgColor.components?[2])
        let testColorDarkBlue = try #require(dark.cgColor.components?[2])

        #expect(Int(testColorUnspecifiedBlue*255) == expectedBlue)
        #expect(Int(testColorLightBlue*255) == expectedBlue)
        #expect(Int(testColorDarkBlue*255) == expectedBlue)
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
                "secondary": {
                    "light": "#00ff00",
                    "dark": "#0000ff"
                }
            }
        }
        """
        let expectedBlue = 170
        let declaration = try SnappThemingParser.parse(from: json)

        let testColor: UIColor = declaration.colors.test
        let testColorUnspecified = testColor.resolvedColor(with: .init(userInterfaceStyle: .unspecified))
        let light = testColor.resolvedColor(with: .init(userInterfaceStyle: .light))
        let dark = testColor.resolvedColor(with: .init(userInterfaceStyle: .dark))

        let testColorUnspecifiedBlue = try #require(testColorUnspecified.cgColor.components?[2])
        let testColorLightBlue = try #require(light.cgColor.components?[2])
        let testColorDarkBlue = try #require(dark.cgColor.components?[2])

        #expect(Int(testColorUnspecifiedBlue*255) == expectedBlue)
        #expect(Int(testColorLightBlue*255) == expectedBlue)
        #expect(Int(testColorDarkBlue*255) == expectedBlue)
    }
}
