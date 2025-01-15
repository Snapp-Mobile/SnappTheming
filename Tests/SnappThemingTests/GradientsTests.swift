//
//  GradientsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

@testable import SnappTheming
import Testing
import SwiftUI

@Suite
struct GradientsTests {
    @Test
    func parseHorizontalLinearGradient() throws {
        let json =
        """
        {
            "gradients": {
                "horizontalLinearGradient": {
                    "colors": [
                        "#000000",
                        "#FF00FF"
                    ],
                    "startPoint": "leading",
                    "endPoint": "trailing"
                }
            }
        }
        """

        let declaration = try SnappThemingParser.parse(from: json)
        let token = try #require(declaration.gradients.cache["horizontalLinearGradient"])
        let configuration = try #require(token.value?.configuration as? SnappThemingLinearGradientConfiguration)

        #expect(
            configuration.startPoint == .leading
            && configuration.endPoint == .trailing
            && configuration.colors.count == 2
        )
        #expect(declaration.gradients.horizontalLinearGradient != nil)
    }

    @Test
    func parseVerticalLinearGradient() throws {
        let json =
        """
        {
            "gradients": {
                "verticalLinearGradient": {
                    "colors": [
                        "#000000",
                        "#FF00FF"
                    ],
                    "startPoint": "top",
                    "endPoint": "bottom"
                }
            }
        }
        """

        let declaration = try SnappThemingParser.parse(from: json)
        let token = try #require(declaration.gradients.cache["verticalLinearGradient"])
        let configuration = try #require(token.value?.configuration as? SnappThemingLinearGradientConfiguration)

        #expect(
            configuration.startPoint == .top
            && configuration.endPoint == .bottom
            && configuration.colors.count == 2
        )
        #expect(declaration.gradients.verticalLinearGradient != nil)
    }

    @Test
    func parseDiagonalLinearGradient() throws {
        let json =
        """
        {
            "gradients": {
                "diagonalLinearGradient": {
                    "colors": [
                        "#000000",
                        "#FF00FF"
                    ],
                    "startPoint": "topLeading",
                    "endPoint": "bottomTrailing"
                }
            }
        }
        """

        let declaration = try SnappThemingParser.parse(from: json)
        let token = try #require(declaration.gradients.cache["diagonalLinearGradient"])
        let configuration = try #require(token.value?.configuration as? SnappThemingLinearGradientConfiguration)

        #expect(
            configuration.startPoint == .topLeading
            && configuration.endPoint == .bottomTrailing
            && configuration.colors.count == 2
        )
        #expect(declaration.gradients.diagonalLinearGradient != nil)
    }

    @Test
    func parseRadialGradient() throws {
        let json =
        """
        {
            "gradients": {
                "radialGradient": {
                    "colors": [
                        "#843912",
                        "#242D2D"
                    ],
                    "center": [
                        2.0,
                        -0.2
                    ],
                    "startRadius": 0,
                    "endRadius": 1075
                }
            }
        }
        """

        let declaration = try SnappThemingParser.parse(from: json)
        let token = try #require(declaration.gradients.cache["radialGradient"])
        let configuration = try #require(token.value?.configuration as? SnappThemingRadialGradientConfiguration)

        #expect(
            configuration.center.x == 2.0
            && configuration.center.y == -0.2
            && configuration.colors.count == 2
            && configuration.startRadius == 0.0
            && configuration.endRadius == 1075.0
        )
        #expect(declaration.gradients.radialGradient != nil)
    }

    @Test
    func parseAngularGradient() throws {
        let json =
        """
        {
            "gradients": {
                "angularGradient": {
                    "colors": [
                        "#843912",
                        "#242D2D"
                    ],
                    "center": [
                        2.0,
                        -0.2
                    ],
                    "startAngle": 0,
                    "endAngle": 180
                }
            }
        }
        """

        let declaration = try SnappThemingParser.parse(from: json)

        let token = try #require(declaration.gradients.cache["angularGradient"])
        let configuration = try #require(token.value?.configuration as? SnappThemingAngularGradientConfiguration)

        #expect(
            configuration.center.x == 2.0
            && configuration.center.y == -0.2
            && configuration.colors.count == 2
            && configuration.startAngle == Angle(degrees: 0.0)
            && configuration.endAngle == Angle(degrees: 180.0)
        )
        #expect(declaration.gradients.angularGradient != nil)
    }
}
