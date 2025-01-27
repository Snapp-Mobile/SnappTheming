//
//  TypographyTest.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 24.01.2025.
//

import Testing
import UIKit

@testable import SnappTheming

@Suite
struct TypographyTest {
    @Test(arguments: [
        """
        {
            "fonts": {
                "Roboto-Regular": \(MockJSONData.font("Roboto-Regular"))
            },
            "typography": {
                "displayLarge": {
                    "font": "$fonts/Roboto-Regular",
                    "fontSize": 60
                }
            }
        }
        """,
        """
        {
            "typography": {
                "displayLarge": {
                    "font": \(MockJSONData.font("Roboto-Regular")),
                    "fontSize": 60
                }
            }
        }
        """,
    ])
    func parseTypography(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let typography: SnappThemingTypographyResolver = declaration.typography
            .displayLarge

        #expect(declaration.typography.cache.count == 1)

        let representation = try #require(
            declaration.typography.cache["displayLarge"]?.value)
        #expect(representation.fontSize.value == 60)

        let uiFont = typography.uiFont
        #expect(
            uiFont.pointSize != configuration.fallbackTypographyFontSize,
            "Parsed typography font size should not match the fallback one."
        )
        #expect(
            uiFont.pointSize == 60.0,
            "Parsed typography font size should be 60.")
    }

}
