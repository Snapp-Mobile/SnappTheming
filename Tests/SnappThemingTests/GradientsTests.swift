//
//  GradientsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SwiftUI
import Testing

@testable import SnappTheming

@Suite
struct GradientsTests {
    @Test(arguments: [
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
        """,
        """
        {
            "colors": {
                "primary": "#000000",
                "secondary": "#FF00FF"
            },
            "gradients": {
                "horizontalLinearGradient": {
                    "colors": [
                        "$colors/primary",
                        "$colors/secondary"
                    ],
                    "startPoint": "leading",
                    "endPoint": "trailing"
                }
            }
        }
        """,
    ])
    func parseHorizontalLinearGradient(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let gradientRepresentation: SnappThemingGradientRepresentation = try #require(
            declaration.gradients.horizontalLinearGradient
        )
        let _: any ShapeStyle = declaration.gradients.horizontalLinearGradient

        let configuration = try #require(
            gradientRepresentation.configuration as? SnappThemingLinearGradientRepresentation)
        let resolvedConfiguration = configuration.resolve(using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.startPoint == .leading)
        #expect(resolvedConfiguration.endPoint == .trailing)
        #expect(resolvedConfiguration.colors.count == 2)
        #expect(resolvedConfiguration.colors[0].toHex() == "#000000")
        #expect(resolvedConfiguration.colors[1].toHex() == "#FF00FF")
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
        let gradientRepresentation: SnappThemingGradientRepresentation = try #require(declaration.gradients.verticalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.verticalLinearGradient

        let configuration = try #require(
            gradientRepresentation.configuration as? SnappThemingLinearGradientRepresentation)

        #expect(configuration.startPoint.value == .top)
        #expect(configuration.endPoint.value == .bottom)
        #expect(configuration.colors.count == 2)
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
        let gradientRepresentation: SnappThemingGradientRepresentation = try #require(declaration.gradients.diagonalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.diagonalLinearGradient
        let configuration = try #require(gradientRepresentation.configuration as? SnappThemingLinearGradientRepresentation)

        #expect(configuration.startPoint.value == .topLeading)
        #expect(configuration.endPoint.value == .bottomTrailing)
        #expect(configuration.colors.count == 2)
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
        let gradientRepresentation: SnappThemingGradientRepresentation = try #require(declaration.gradients.radialGradient)
        let _: any ShapeStyle = declaration.gradients.radialGradient
        let configuration = try #require(
            gradientRepresentation.configuration
                as? SnappThemingRadialGradientConfiguration)

        #expect(
            configuration.center.x == 2.0
                && configuration.center.y == -0.2
                && configuration.colors.count == 2
                && configuration.startRadius == 0.0
                && configuration.endRadius == 1075.0
        )
    }

    @Test(arguments: [
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
        """,
        """
        {
            "colors": {
                "primary": "#843912",
                "secondary": "#242D2D"
            },
            "gradients": {
                "angularGradient": {
                    "colors": [
                        "$colors/primary",
                        "$colors/secondary"
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
        """,
    ])
    func parseAngularGradient(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let gradientRepresentation: SnappThemingGradientRepresentation = try #require(declaration.gradients.angularGradient)
        let configuration = try #require(gradientRepresentation.configuration as? SnappThemingAngularGradientRepresentation)
        let resolvedConfiguration = configuration.resolve(using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.center.x == 2.0)
        #expect(resolvedConfiguration.center.y == -0.2)
        #expect(resolvedConfiguration.colors.count == 2)
        #expect(resolvedConfiguration.startAngle == Angle(degrees: 0.0))
        #expect(resolvedConfiguration.endAngle == Angle(degrees: 180.0))
        #expect(resolvedConfiguration.colors[0].toHex() == "#843912")
        #expect(resolvedConfiguration.colors[1].toHex() == "#242D2D")
    }
}
