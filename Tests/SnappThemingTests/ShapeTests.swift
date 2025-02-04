//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SwiftUI
import Testing

@testable import SnappTheming

enum ShapeParserError: Error {
    case invalidShapeType
}

@Suite
struct ShapeTests {
    @Test
    func parseRectangle() throws {
        let json =
            """
            {
                "shapes": {
                    "rect": {
                        "type": "rectangle"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.rect)
        let _ = shapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        switch shapeRepresentation.shapeType {
        case .rectangle:
            #expect(Bool(true), "Expected shape should be rectangle")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseEllipse() throws {
        let json =
            """
            {
                "shapes": {
                    "ellipse": {
                        "type": "ellipse"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.ellipse)
        let _ = shapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        switch shapeRepresentation.shapeType {
        case .ellipse:
            #expect(Bool(true), "Expected shape should be ellipse")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseCircle() throws {
        let json =
            """
            {
                "shapes": {
                    "circle": {
                        "type": "circle"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.circle)
        let _ = shapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        switch shapeRepresentation.shapeType {
        case .circle:
            #expect(Bool(true), "Expected shape should be circle")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseCapsule() throws {
        let json =
            """
            {
                "shapes": {
                    "circularCapsule": {
                        "type": "capsule",
                        "style": "circular"
                    },
                    "continuousCapsule": {
                        "type": "capsule",
                        "style": "continuous"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let circularCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.circularCapsule)
        let continuousCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.continuousCapsule)

        let _ = circularCapsuleShapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        let _ = continuousCapsuleShapeRepresentation.resolver(configuration: declaration.shapes.configuration)

        switch (circularCapsuleShapeRepresentation.shapeType, continuousCapsuleShapeRepresentation.shapeType) {
        case (.capsule(let styleFirst), .capsule(let styleSecond)):
            #expect(styleFirst.value == .circular, "First capsule rounded corner style should be circular")
            #expect(styleSecond.value == .continuous, "Second capsule rounded corner style should be continuous")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseRoundedRectanglesWithRadius() throws {
        let json =
            """
            {
                "metrics": {
                    "medium": 12
                },
                "shapes": {
                    "roundedRectangle": {
                        "type": "roundedRectangle",
                        "cornerRadius": "$metrics/medium",
                        "style": "circular"
                    },
                    "roundedRectangleNoStyle": {
                        "type": "roundedRectangle",
                        "cornerRadius": "$metrics/medium"
                    },
                    "roundedRectangleAlt": {
                        "type": "roundedRectangle",
                        "cornerRadius": 24,
                        "style": "continuous"
                    },
                    "roundedRectangleAltWithWrongAlias": {
                        "type": "roundedRectangle",
                        "cornerRadius": "$metrics/mediYm",
                        "style": "continuous"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.shapes.configuration
        let firstShapeRepresentation = try #require(declaration.shapes.roundedRectangle)
        let secondShapeRepresentation = try #require(declaration.shapes.roundedRectangleAlt)
        let thirdShapeRepresentation = try #require(declaration.shapes.roundedRectangleAltWithWrongAlias)

        let _ = firstShapeRepresentation.resolver(configuration: fallbackConfiguration)
        let _ = secondShapeRepresentation.resolver(configuration: fallbackConfiguration)
        let _ = thirdShapeRepresentation.resolver(configuration: fallbackConfiguration)

        switch (firstShapeRepresentation.shapeType, secondShapeRepresentation.shapeType, thirdShapeRepresentation.shapeType) {
        case (
            .roundedRectangleWithRadius(let first),
            .roundedRectangleWithRadius(let second),
            .roundedRectangleWithRadius(let third)
        ):
            let firstRadius = try #require(fallbackConfiguration.metrics.resolver.resolve(first.token))
            #expect(
                firstRadius == 12,
                "First radius should be 12"
            )
            #expect(
                first.roundedCornerStyle == .circular,
                "First style should be circular"
            )
            let secondRadius = try #require(fallbackConfiguration.metrics.resolver.resolve(second.token))
            #expect(
                secondRadius == 24,
                "Second radius should be 24"
            )
            #expect(
                second.roundedCornerStyle == .continuous,
                "Second style should be continuous"
            )
            #expect(
                fallbackConfiguration.metrics.resolver.resolve(third.token) == nil,
                "roundedRectangleAltWithWrongAlias should not be resolved"
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseRoundedRectanglesWithSize() throws {
        let json =
            """
            {
                "metrics": {
                    "sideWidth": 15
                },
                "shapes": {
                    "roundedRectangle": {
                        "type": "roundedRectangle",
                        "cornerSize": {
                            "width": "$metrics/sideWidth",
                            "height": 30
                        },
                        "style": "circular"
                    },
                    "roundedRectangleAlt": {
                        "type": "roundedRectangle",
                        "cornerSize": {
                            "width": 30,
                            "height": 60
                        },
                        "style": "continuous"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.shapes.configuration
        let roundedRectangleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.roundedRectangle)
        let roundedRectangleAltShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.roundedRectangleAlt)
        let _ = roundedRectangleShapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        let _ = roundedRectangleAltShapeRepresentation.resolver(configuration: declaration.shapes.configuration)

        switch (
            roundedRectangleShapeRepresentation.shapeType,
            roundedRectangleAltShapeRepresentation.shapeType
        ) {
        case (
            .roundedRectangleWithSize(let first),
            .roundedRectangleWithSize(let second)
        ):
            let firstWidth = try #require(fallbackConfiguration.metrics.resolver.resolve(first.width))
            #expect(firstWidth == 15.0, "First rounded rectangle width should be 15.0")
            let firstHeight = try #require(fallbackConfiguration.metrics.resolver.resolve(first.height))
            #expect(firstHeight == 30.0, "First rounded rectangle height should be 30.0")
            #expect(
                first.roundedCornerStyle == .circular,
                "First rounded rectangle rounded corner style should be circular"
            )
            let secondWidth = try #require(fallbackConfiguration.metrics.resolver.resolve(second.width))
            #expect(secondWidth == 30.0, "Second rounded rectangle width should be 30.0")
            let secondHeight = try #require(fallbackConfiguration.metrics.resolver.resolve(second.height))
            #expect(secondHeight == 60.0, "Second rounded rectangle height should be 60.0")
            #expect(
                second.roundedCornerStyle == .continuous,
                "Second rounded rectangle rounded corner style should be continuous"
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseUnevenRoundedRectangle() throws {
        let json =
            """
            {
                "shapes": {
                    "funkyRect": {
                        "type": "unevenRoundedRectangle",
                        "cornerRadii": {
                            "topLeading": 10,
                            "bottomLeading": 20,
                            "bottomTrailing": 30,
                            "topTrailing": 40
                        },
                        "style": "circular"
                    },
                    "funkyRectAlt": {
                        "type": "unevenRoundedRectangle",
                        "cornerRadii": {
                            "topLeading": 50,
                            "bottomLeading": 60,
                            "bottomTrailing": 70,
                            "topTrailing": 80
                        },
                        "style": "continuous"
                    },
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.shapes.configuration
        let funkyRectShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.funkyRect)
        let funkyRectAltShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.funkyRectAlt)
        let _ = funkyRectShapeRepresentation.resolver(configuration: declaration.shapes.configuration)
        let _ = funkyRectAltShapeRepresentation.resolver(configuration: declaration.shapes.configuration)

        switch (funkyRectShapeRepresentation.shapeType, funkyRectAltShapeRepresentation.shapeType) {
        case (
            .unevenRoundedRectangle(let first),
            .unevenRoundedRectangle(let second)
        ):
            let firstTopLeading = try #require(
                fallbackConfiguration.metrics.resolver.resolve(first.cornerRadiiValue.topLeading)
            )
            #expect(
                firstTopLeading == 10.0,
                "First uneven rectangle top leading radius should be 10.0"
            )
            let firstBottomLeading = try #require(
                fallbackConfiguration.metrics.resolver.resolve(first.cornerRadiiValue.bottomLeading)
            )
            #expect(
                firstBottomLeading == 20.0,
                "First uneven rectangle bottom leading radius should be 20.0"
            )
            let firstBottomTrailing = try #require(
                fallbackConfiguration.metrics.resolver.resolve(first.cornerRadiiValue.bottomTrailing)
            )
            #expect(
                firstBottomTrailing == 30.0,
                "First uneven rectangle bottom trailing radius should be 30.0"
            )
            let firstTopTrailing = try #require(
                fallbackConfiguration.metrics.resolver.resolve(first.cornerRadiiValue.topTrailing)
            )
            #expect(
                firstTopTrailing == 40.0,
                "First uneven rectangle top trailing radius should be 40.0"
            )
            #expect(
                first.roundedCornerStyle == .circular,
                "First uneven rectangle rounded corner style should be circular"
            )

            let secondTpLeading = try #require(
                fallbackConfiguration.metrics.resolver.resolve(second.cornerRadiiValue.topLeading)
            )
            #expect(
                secondTpLeading == 50.0,
                "Second uneven rectangle top leading radius should be 50.0"
            )
            let secondBottomLeading = try #require(
                fallbackConfiguration.metrics.resolver.resolve(second.cornerRadiiValue.bottomLeading)
            )
            #expect(
                secondBottomLeading == 60.0,
                "Second uneven rectangle bottom leading radius should be 60.0"
            )
            let secondBottomTrailing = try #require(
                fallbackConfiguration.metrics.resolver.resolve(second.cornerRadiiValue.bottomTrailing)
            )
            #expect(
                secondBottomTrailing == 70.0,
                "Second uneven rectangle bottom trailing radius should be 70.0"
            )
            let secondTopTrailing = try #require(
                fallbackConfiguration.metrics.resolver.resolve(second.cornerRadiiValue.topTrailing)
            )
            #expect(
                secondTopTrailing == 80.0,
                "Second uneven rectangle top trailing radius should be 80.0"
            )
            #expect(
                second.roundedCornerStyle == .continuous,
                "Second uneven rectangle rounded corner style should be continuous"
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

}
