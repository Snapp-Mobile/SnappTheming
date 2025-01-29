//
//  ToggleStyleTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 28.01.2025.
//

import SwiftUI
import Testing
import UIKit

@testable import SnappTheming

@Suite
struct ToggleStyleTests {
    @Test(arguments: [
        """
        {
            "colors": {
                "appGreen": "#C22973",
                "appGray": "#7A214B"
            },
            "toggleStyle": {
                "primary": {
                    "tintColor": "$colors/appGreen",
                    "disabledTintColor": "$colors/appGray"
                }
            }
        }
        """,
        """
        {
            "toggleStyle": {
                "primary": {
                    "tintColor": "#C22973",
                    "disabledTintColor": "#7A214B"
                }
            }
        }
        """,
    ])
    func parseToggleStyleWithSuccess(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let _ = try #require(declaration.toggleStyle.cache["primary"]?.value)
        let toggleStyle: SnappThemingToggleStyleResolver = declaration.toggleStyle.primary
        let toggleStyleFallbackConfiguration = declaration.toggleStyle.configuration

        #expect(declaration.toggleStyle.cache.count == 1)

        let tintColor: Color = toggleStyle.tintColor
        #expect(tintColor != toggleStyleFallbackConfiguration.fallbackTintColor)
        #expect(tintColor == Color(hex: "#C22973"))

        let disabledTintColor: Color = toggleStyle.disabledTintColor
        #expect(disabledTintColor != toggleStyleFallbackConfiguration.fallbackDisabledTintColor)
        #expect(disabledTintColor == Color(hex: "#7A214B"))
    }

    @Test(arguments: [
        """
        {
            "colors": {
                "appGreen": "#C22973",
                "appGray": "#7A214B"
            },
            "toggleStyle": {
                "primary": {
                    "tintColor": "$colors/primary",
                    "disabledTintColor": "$colors/secondary"
                }
            }
        }
        """,
        """
        {
            "toggleStyle": {
                "primary": {
                    "tintColor": "$colors/primary",
                    "disabledTintColor": "$colors/secondary"
                }
            }
        }
        """,
    ])
    func parseToggleStyleWithWrongAliases(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let _ = try #require(declaration.toggleStyle.cache["primary"])
        #expect(declaration.toggleStyle.cache.count == 1)

        let toggleStyle: SnappThemingToggleStyleResolver = declaration.toggleStyle.primary
        let toggleStyleFallbackConfiguration = declaration.toggleStyle.configuration
        let tintColor: Color = toggleStyle.tintColor
        #expect(tintColor == toggleStyleFallbackConfiguration.fallbackTintColor)
        let disabledTintColor: Color = toggleStyle.disabledTintColor
        #expect(disabledTintColor == toggleStyleFallbackConfiguration.fallbackTintColor)
    }

    @Test()
    func testEmptyToggleStyle() throws {
        let toggleStyle: SnappThemingToggleStyleResolver = .empty()

        let tintColor: Color = toggleStyle.tintColor
        #expect(tintColor == .clear)
        let disabledTintColor = toggleStyle.disabledTintColor
        #expect(disabledTintColor == .clear)
    }
}
