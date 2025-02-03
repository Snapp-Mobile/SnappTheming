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
    @Test(arguments: linearGradients)
    func parseHorizontalLinearGradient(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)

        let horizontalLinearGradientRepresentation = try #require(
            declaration.gradients.horizontalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.horizontalLinearGradient
        let horizontalLinearGradientConfiguration = try #require(
            horizontalLinearGradientRepresentation.configuration
                as? SnappThemingLinearGradientRepresentation)
        let resolvedHorizontalConfiguration = horizontalLinearGradientConfiguration.resolve(
            using: declaration.gradients.configuration)

        #expect(resolvedHorizontalConfiguration.startPoint == .leading)
        #expect(resolvedHorizontalConfiguration.endPoint == .trailing)
        #expect(resolvedHorizontalConfiguration.colors.count == 2)
        #expect(resolvedHorizontalConfiguration.colors[0].toHex() == "#000000")
        #expect(resolvedHorizontalConfiguration.colors[1].toHex() == "#FF00FF")

        let verticalLinearGradientRepresentation = try #require(
            declaration.gradients.verticalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.verticalLinearGradient
        let verticalLinearGradientConfiguration = try #require(
            verticalLinearGradientRepresentation.configuration
                as? SnappThemingLinearGradientRepresentation)
        let resolvedVerticalConfiguration = verticalLinearGradientConfiguration.resolve(
            using: declaration.gradients.configuration)

        #expect(resolvedVerticalConfiguration.startPoint == .top)
        #expect(resolvedVerticalConfiguration.endPoint == .bottom)
        #expect(resolvedVerticalConfiguration.colors.count == 2)
        #expect(resolvedVerticalConfiguration.colors[0].toHex() == "#AA0000")
        #expect(resolvedVerticalConfiguration.colors[1].toHex() == "#FF00AA")

        let diagonalLinearGradientRepresentation = try #require(
            declaration.gradients.diagonalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.diagonalLinearGradient
        let diagonalLinearGradientConfiguration = try #require(
            diagonalLinearGradientRepresentation.configuration
                as? SnappThemingLinearGradientRepresentation)
        let resolveDiagonalConfiguration = diagonalLinearGradientConfiguration.resolve(
            using: declaration.gradients.configuration)

        #expect(resolveDiagonalConfiguration.startPoint == .topLeading)
        #expect(resolveDiagonalConfiguration.endPoint == .bottomTrailing)
        #expect(resolveDiagonalConfiguration.colors.count == 2)
        #expect(resolveDiagonalConfiguration.colors[0].toHex() == "#00AA00")
        #expect(resolveDiagonalConfiguration.colors[1].toHex() == "#AA00FF")
    }

    @Test(arguments: horizontalLinearGradientsWithBrokenAliases)
    func parseHorizontalLinearGradientWithBrokenAliases(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.gradients.configuration
        let gradientRepresentation = try #require(declaration.gradients.horizontalLinearGradient)
        let _: any ShapeStyle = declaration.gradients.horizontalLinearGradient

        let configuration = try #require(
            gradientRepresentation.configuration
                as? SnappThemingLinearGradientRepresentation)
        let resolvedConfiguration = configuration.resolve(using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.startPoint == fallbackConfiguration.fallbackUnitPoint)
        #expect(resolvedConfiguration.endPoint == fallbackConfiguration.fallbackUnitPoint)
        #expect(resolvedConfiguration.colors.count == 1)
        #expect(resolvedConfiguration.colors[0].toHex() == fallbackConfiguration.fallbackColor.toHex())
    }

    @Test(arguments: radialGradoients)
    func parseRadialGradient(json: String) throws {
        typealias Radial = SnappThemingRadialGradientRepresentation
        let declaration = try SnappThemingParser.parse(from: json)
        let gradientRepresentation = try #require(declaration.gradients.radialGradient)
        let _: any ShapeStyle = declaration.gradients.radialGradient
        let configuration = try #require(gradientRepresentation.configuration as? Radial)
        let resolvedConfiguration = configuration.resolve(using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.center.x == 2.0)
        #expect(resolvedConfiguration.center.y == -0.2)
        #expect(resolvedConfiguration.colors.count == 2)
        #expect(resolvedConfiguration.startRadius == 90.0)
        #expect(resolvedConfiguration.endRadius == 1075.0)
    }

    @Test(arguments: angularGradients)
    func parseAngularGradient(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let gradientRepresentation = try #require(declaration.gradients.angularGradient)
        let _: any ShapeStyle = declaration.gradients.angularGradient
        let configuration = try #require(
            gradientRepresentation.configuration
                as? SnappThemingAngularGradientRepresentation)
        let resolvedConfiguration = configuration.resolve(
            using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.center.x == 2.0)
        #expect(resolvedConfiguration.center.y == -0.2)

        #expect(resolvedConfiguration.startAngle == Angle(degrees: 90.0))
        #expect(resolvedConfiguration.endAngle == Angle(degrees: 180.0))

        #expect(resolvedConfiguration.colors.count == 2)
        #expect(resolvedConfiguration.colors[0].toHex() == "#843912")
        #expect(resolvedConfiguration.colors[1].toHex() == "#242D2D")
    }

    @Test(arguments: angularGradientsWithBrokenAliases)
    func parseAngularGradientWithBadAliases(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let _: any ShapeStyle = declaration.gradients.angularGradient
        let fallbackConfiguration = declaration.gradients.configuration
        let gradientRepresentation = try #require(declaration.gradients.angularGradient)
        let configuration = try #require(
            gradientRepresentation.configuration as? SnappThemingAngularGradientRepresentation)
        let resolvedConfiguration = configuration.resolve(using: declaration.gradients.configuration)

        #expect(resolvedConfiguration.center == .center)

        #expect(resolvedConfiguration.startAngle == fallbackConfiguration.fallbackAngle)
        #expect(resolvedConfiguration.endAngle == fallbackConfiguration.fallbackAngle)

        #expect(resolvedConfiguration.colors.count == 1)
        #expect(resolvedConfiguration.colors[0].toHex() == fallbackConfiguration.fallbackColor.toHex())
    }

    @Test()
    func parseNotSupportedGradientType() throws {
        let json =
            """
            {
                "gradients": {
                    "notSupportedGradient": {
                        "colors": [
                            "#000000",
                            "#FF00FF"
                        ],
                        "finishPoint": "top",
                        "middlePoint": "bottom",
                        "beginPoint": "bottom"
                    }
                }
            }
            """
        let declaration = try SnappThemingParser.parse(from: json)
        let _: any ShapeStyle = declaration.gradients.angularGradient
        let fallbackConfiguration = declaration.gradients.configuration
        let gradientRepresentation = try #require(declaration.gradients.notSupportedGradient)
        let configuration = try #require(
            gradientRepresentation.configuration as? SnappThemingClearShapeStyleConfiguration)

        #expect(configuration.shapeStyleUsing(fallbackConfiguration) == Color.clear)
    }
}

private let linearGradients = [
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
            },
            "verticalLinearGradient": {
                "colors": [
                    "#AA0000",
                    "#FF00AA"
                ],
                "startPoint": "top",
                "endPoint": "bottom"
            },
            "diagonalLinearGradient": {
                "colors": [
                    "#00AA00",
                    "#AA00FF"
                ],
                "startPoint": "topLeading",
                "endPoint": "bottomTrailing"
            }
        }
    }
    """,
    """
    {
        "colors": {
            "primary": "#000000",
            "secondary": "#FF00FF",
            "primaryAlt": "#AA0000",
            "secondaryAlt": "#FF00AA",
            "tertiary": "#00AA00",
            "subTertiary": "#AA00FF"
        },
        "gradients": {
            "horizontalLinearGradient": {
                "colors": [
                    "$colors/primary",
                    "$colors/secondary"
                ],
                "startPoint": "leading",
                "endPoint": "trailing"
            },
            "verticalLinearGradient": {
                "colors": [
                    "$colors/primaryAlt",
                    "$colors/secondaryAlt"
                ],
                "startPoint": "top",
                "endPoint": "bottom"
            },
            "diagonalLinearGradient": {
                "colors": [
                    "$colors/tertiary",
                    "$colors/subTertiary"
                ],
                "startPoint": "topLeading",
                "endPoint": "bottomTrailing"
            }
        }
    }
    """,
]

private let horizontalLinearGradientsWithBrokenAliases = [
    """
    {
        "colors": {
            "primary": "#000000",
            "secondary": "#FF00FF"
        },
        "gradients": {
            "horizontalLinearGradient": {
                "colors": [
                    "$colors/primaryWrong",
                    "$colors/secondaryWrong"
                ],
                "startPoint": "leading",
                "endPoint": "trailing"
            }
        }
    }
    """
]

private let angularGradients = [
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
                "startAngle": 90,
                "endAngle": 180
            }
        }
    }
    """,
    """
    {
        "metrics": {
            "quaterCircle": 90.0,
            "halfCircle": 180.0
        },
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
                "startAngle": "$metrics/quaterCircle",
                "endAngle": "$metrics/halfCircle"
            }
        }
    }
    """,
]

private let angularGradientsWithBrokenAliases = [
    """
    {
        "metrics": {
            "quaterCircleWrong": 90.0,
            "halfCircleWrong": 180.0
        },
        "colors": {
            "primaryWrong": "#843912",
            "secondaryWrong": "#242D2D"
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
                "startAngle": "$metrics/quaterCircle",
                "endAngle": "$metrics/halfCircle"
            }
        }
    }
    """
]

private let radialGradoients = [
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
                "startRadius": 90,
                "endRadius": 1075
            }
        }
    }
    """,
    """
    {
        "metrics": {
            "quaterCircle": 90.0,
            "bigNumber": 1075.0
        },
        "colors": {
            "primary": "#843912",
            "secondary": "#242D2D"
        },
        "gradients": {
            "radialGradient": {
                "colors": [
                    "$colors/primary",
                    "$colors/secondary"
                ],
                "center": [
                    2.0,
                    -0.2
                ],
                "startRadius": "$metrics/quaterCircle",
                "endRadius": "$metrics/bigNumber"
            }
        }
    }
    """,
]
