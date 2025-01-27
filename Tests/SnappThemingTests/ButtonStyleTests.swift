//
//  ButtonStyleTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 22.01.2025.
//

import SwiftUI
import Testing

@testable import SnappTheming

@Suite
struct ButtonStyleTests {
    private let configuration = SnappThemingParserConfiguration(
        fallbackButtonStyle: .init(
            surfaceColor: .clear,
            textColor: .clear,
            borderColor: .clear,
            borderWidth: 777,
            shape: .ellipse,
            typography: .init(.system, fontSize: 99)
        )
    )

    @MainActor
    @Test(arguments: correctJSONs)
    func testSuccessfulParsing(json: String) async throws {
        let declaration = try SnappThemingParser.parse(from: json, using: configuration)
        let _: SnappThemingButtonStyleRepresentation = try #require(declaration.buttonStyles.primary)
        let buttonStyleResolver: SnappThemingButtonStyleResolver = declaration.buttonStyles.primary
        let buttonStyle: some ButtonStyle = declaration.buttonStyles.primary
        let borderWidth = buttonStyleResolver.borderWidth
        let shape = buttonStyleResolver.shape
        let typography = buttonStyleResolver.typography
        #expect(buttonStyle is SnappThemingButtonStyle)
        #expect(
            borderWidth != configuration.fallbackButtonStyle.borderWidth,
            "Parsed button style border width should not match the fallback border width."
        )
        #expect(borderWidth == 1.0, "Parsed button style border width should be equal to 1.")
        #expect(
            shape != configuration.fallbackButtonStyle.shape,
            "Parsed button style shape should not match the fallback shape."
        )
        #expect(shape == .circle, "Parsed button style shape should be equal to circle.")
        #expect(
            typography.uiFont.pointSize != configuration.fallbackButtonStyle.typography.uiFont.pointSize,
            "Parsed button style typography should not match the fallback typography."
        )
        #expect(typography.uiFont.pointSize == 16, "Parsed button style typography font size should be equal to 16.")
    }

    @Test(arguments: brokenAliasesJSONs)
    func testFallbackParsing(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json, using: configuration)
        let buttonStyleResolver: SnappThemingButtonStyleResolver = declaration.buttonStyles.primary

        let borderWidth = buttonStyleResolver.borderWidth
        #expect(
            borderWidth == configuration.fallbackButtonStyle.borderWidth,
            "Parsed button style border width should match the fallback border width."
        )
        #expect(borderWidth == 777, "Parsed button style border width should fallback to 777.")

        let typography = buttonStyleResolver.typography
        #expect(
            typography.uiFont.pointSize == configuration.fallbackButtonStyle.typography.uiFont.pointSize,
            "Parsed button style typography should match the fallback typography."
        )
        #expect(typography.uiFont.pointSize == 99, "Parsed button style typography font size should fallback to 99.")

        let surfaceColor = buttonStyleResolver.surfaceColor
        #expect(
            surfaceColor.normal == .clear,
            "Parsed button style surfaceColor should fallback to clear."
        )
    }

    @Test(arguments: invalidJSONs)
    func testFailedParsing(json: String) throws {
        do {
            let _ = try SnappThemingParser.parse(from: json, using: configuration)
            Issue.record("Parser should throw decoding error when paring invalid JSON")
        } catch {
            #expect(error is DecodingError)
        }
    }

    private static let brokenAliasesJSONs = [
        """
        {
            "buttonStyles": {
                "primary": {
                    "surfaceColor": {
                        "normal": "#1A1A1A",
                        "pressed": "#3D3D3D",
                        "disabled": "#FFFFFF0F"
                    },
                    "borderColor": "$colors/primary",
                    "textColor": {
                        "normal": "#FFFFFF",
                        "pressed": "#FFFFFF",
                        "disabled": "#888888"
                    },
                    "borderWidth": "$metrics/borderWidth",
                    "typography": "$typography/textSmall",
                    "shape": "$shapes/roundedRectangle"
                }
            }
        }
        """,
        """
            {
                "buttonStyles": {
                    "primary": {
                        "surfaceColor": "#1A1A1A",
                        "borderColor": "#FFFFFF0F",
                        "textColor": "#FFFFFF",
                        "borderWidth": "$metrics/small",
                        "typography": "$typography/textSmall",
                        "shape": "$shapes/roundedRectangle"
                    }
                }
            }
        """,
    ]

    private static let invalidJSONs = [
        """
        {
            "buttonStyles": {
                "primary": {
                    "borderColor": {
                        "normal": "#FFFFFF0F",
                        "pressed": "#FFFFFF1F",
                        "disabled": "#FFFFFF00"
                    },
                    "textColor": {
                        "normal": "#FFFFFF",
                        "pressed": "#FFFFFF",
                        "disabled": "#888888"
                    },
                    "borderWidth": "1",
                    "shape": "$shapes/roundedRectangle"
                }
            }
        }
        """,
        """
            {
                "buttonStyles": {
                    "primary": {
                        "surfaceColor": "#1A1A1A",
                        "borderColor": "#FFFFFF0F",
                        "textColor": "#FFFFFF",
                        "shape": "$shapes/roundedRectangle"
                    }
                }
            }
        """,
    ]

    private static let correctJSONs = [
        """
        {
            "buttonStyles": {
                "primary": {
                    "surfaceColor": {
                        "normal": "#1A1A1A",
                        "pressed": "#3D3D3D",
                        "disabled": "#FFFFFF0F"
                    },
                    "borderColor": {
                        "normal": "#FFFFFF0F",
                        "pressed": "#FFFFFF1F",
                        "disabled": "#FFFFFF00"
                    },
                    "textColor": {
                        "normal": "#FFFFFF",
                        "pressed": "#FFFFFF",
                        "disabled": "#888888"
                    },
                    "borderWidth": 1,
                    "typography": {
                        "font": \(MockJSONData.font("Roboto-Regular")),
                        "fontSize": 16
                    },
                    "shape": { "type": "circle" }
                }
            }
        }
        """,
        """
        {
            "buttonStyles": {
                "primary": {
                    "surfaceColor": "#1A1A1A",
                    "borderColor": "#FFFFFF0F",
                    "textColor": "#FFFFFF",
                    "borderWidth": 1,
                    "typography": {
                        "font": \(MockJSONData.font("Roboto-Regular")),
                        "fontSize": 16
                    },
                    "shape": { "type": "circle" }
                }
            }
        }
        """,
    ]

}
