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
        let resolvedShape = shapeRepresentation.shapeType.resolve(using: declaration.shapes.configuration)
        switch shapeRepresentation.shapeType {
        case .rectangle:
            #expect(resolvedShape.cornerRadius == 0, "Default rectangle shape corner radius should be 0")
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
        let resolvedShape = shapeRepresentation.shapeType.resolve(using: declaration.shapes.configuration)
        switch shapeRepresentation.shapeType {
        case .ellipse:
            #expect(resolvedShape.cornerRadius == 1000, "Default ellipse shape corner radius should be 1000")
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
        let resolvedShape = shapeRepresentation.shapeType.resolve(using: declaration.shapes.configuration)
        switch resolvedShape {
        case .circle:
            #expect(resolvedShape.cornerRadius == 1000, "Default circle shape corner radius should be 1000")
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
                        "value": {
                            "style": "circular"
                        }
                    },
                    "continuousCapsule": {
                        "type": "capsule",
                        "value": {
                            "style": "continuous"
                        }
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let circularCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.circularCapsule)
        let continuousCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.continuousCapsule)

        let firstShape = circularCapsuleShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)
        let secondShape = continuousCapsuleShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)

        switch (firstShape, secondShape) {
        case (.capsule(let styleFirst), .capsule(let styleSecond)):
            #expect(firstShape.cornerRadius == 1000, "Default capsule shape corner radius should be 1000")
            #expect(secondShape.cornerRadius == 1000, "Default capsule shape corner radius should be 1000")
            #expect(styleFirst == .circular, "First capsule rounded corner style should be circular")
            #expect(styleSecond == .continuous, "Second capsule rounded corner style should be continuous")
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
                        "value": {
                            "cornerRadius": "$metrics/medium",
                            "style": "circular"
                        }
                    },
                    "roundedRectangleNoStyle": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerRadius": "$metrics/medium"
                        }
                    },
                    "roundedRectangleAlt": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerRadius": 24,
                            "style": "continuous"
                        }
                    },
                    "roundedRectangleAltWithWrongAlias": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerRadius": "$metrics/mediYm",
                            "style": "continuous"
                        }
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.shapes.configuration
        let roundedRectangleShapeRepresentation = try #require(declaration.shapes.roundedRectangle)
        let roundedRectangleAltShapeRepresentation = try #require(declaration.shapes.roundedRectangleAlt)
        let wrongAliasShapeRepresentation = try #require(declaration.shapes.roundedRectangleAltWithWrongAlias)
        let firstShape = roundedRectangleShapeRepresentation.shapeType
            .resolve(using: fallbackConfiguration)
        let secondShape = roundedRectangleAltShapeRepresentation.shapeType
            .resolve(using: fallbackConfiguration)
        let thirdShape = wrongAliasShapeRepresentation.shapeType
            .resolve(using: fallbackConfiguration)
        switch (firstShape, secondShape, thirdShape) {
        case (
            .roundedRectangleWithRadius(let radiusFirst, let styleFirst),
            .roundedRectangleWithRadius(let radiusSecond, let styleSecond),
            .roundedRectangleWithRadius(let radiusThird, let styleThird)
        ):
            #expect(firstShape.cornerRadius == 12, "Default roundedRectangleWithRadius shape corner radius should be 12")
            #expect(secondShape.cornerRadius == 24, "Default roundedRectangleWithRadius shape corner radius should be 24")
            #expect(
                thirdShape.cornerRadius == fallbackConfiguration.fallbackCornerRadius.cgFloat,
                "Default roundedRectangleWithRadius shape corner radius should fallback to 0")
            #expect(radiusFirst == 12, "First radius should be 12")
            #expect(styleFirst == .circular, "First style should be circular")
            #expect(radiusSecond == 24, "Second radius should be 24")
            #expect(styleSecond == .continuous, "Second style should be continuous")
            #expect(radiusThird == fallbackConfiguration.fallbackCornerRadius.cgFloat, "Second radius should fallback to 0")
            #expect(styleThird == fallbackConfiguration.fallbackRoundedCornerStyle, "Second style should fallback to circular")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseRoundedRectanglesWithSize() throws {
        let json =
            """
            {
                "shapes": {
                    "roundedRectangle": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerSize": {
                                "width": 15,
                                "height": 30
                            },
                            "style": "circular"
                        }
                    },
                    "roundedRectangleAlt": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerSize": {
                                "width": 30,
                                "height": 60
                            },
                            "style": "continuous"
                        }
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)

        let roundedRectangleShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.roundedRectangle)
        let roundedRectangleAltShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.roundedRectangleAlt)
        let firstShape = roundedRectangleShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)
        let secondShape = roundedRectangleAltShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)

        switch (firstShape, secondShape) {
        case (
            .roundedRectangleWithSize(let sizeFirst, let styleFirst),
            .roundedRectangleWithSize(let sizeSecond, let styleSecond)
        ):
            #expect(
                firstShape.cornerRadius == 15,
                "Default roundedRectangleWithSize shape corner radius should be equal to width(15)"
            )
            #expect(
                secondShape.cornerRadius == 30,
                "Default roundedRectangleWithSize shape corner radius should be equal to width(30)"
            )
            #expect(sizeFirst.width == 15.0, "First rounded rectangle width should be 15.0")
            #expect(sizeFirst.height == 30.0, "First rounded rectangle height should be 30.0")
            #expect(styleFirst == .circular, "First rounded rectangle rounded corner style should be circular")
            #expect(sizeSecond.width == 30.0, "Second rounded rectangle width should be 30.0")
            #expect(sizeSecond.height == 60.0, "Second rounded rectangle height should be 60.0")
            #expect(styleSecond == .continuous, "Second rounded rectangle rounded corner style should be continuous")
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
                        "value": {
                            "cornerRadii": {
                                "topLeading": 0,
                                "bottomLeading": 20,
                                "bottomTrailing": 0,
                                "topTrailing": 20
                            },
                            "style": "circular"
                        }
                    },
                    "funkyRectAlt": {
                        "type": "unevenRoundedRectangle",
                        "value": {
                            "cornerRadii": {
                                "topLeading": 20,
                                "bottomLeading": 0,
                                "bottomTrailing": 20,
                                "topTrailing": 0
                            },
                            "style": "continuous"
                        }
                    },
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let funkyRectShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.funkyRect)
        let funkyRectAltShapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.funkyRectAlt)
        let firstShape = funkyRectShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)
        let secondShape = funkyRectAltShapeRepresentation.shapeType
            .resolve(using: declaration.shapes.configuration)

        switch (firstShape, secondShape) {
        case (
            .unevenRoundedRectangle(let radiiFirst, let styleFirst),
            .unevenRoundedRectangle(let radiiSecond, let styleSecond)
        ):
            #expect(
                firstShape.cornerRadius == 0,
                "Default unevenRoundedRectangle shape corner radius should be equal to topLeading(0)"
            )
            #expect(
                secondShape.cornerRadius == 20,
                "Default unevenRoundedRectangle shape corner radius should be to topLeading(20)"
            )
            #expect(radiiFirst.topLeading == 0.0, "First uneven rectangle top leading radius should be 0.0")
            #expect(radiiFirst.bottomLeading == 20.0, "First uneven rectangle bottom leading radius should be 20.0")
            #expect(radiiFirst.bottomTrailing == 0.0, "First uneven rectangle bottom trailing radius should be 0.0")
            #expect(radiiFirst.topTrailing == 20.0, "First uneven rectangle top trailing radius should be 20.0")
            #expect(styleFirst == .circular, "First uneven rectangle rounded corner style should be circular")
            #expect(radiiSecond.topLeading == 20.0, "Second uneven rectangle top leading radius should be 20.0")
            #expect(radiiSecond.bottomLeading == 0.0, "Second uneven rectangle bottom leading radius should be 0.0")
            #expect(radiiSecond.bottomTrailing == 20.0, "Second uneven rectangle bottom trailing radius should be 20.0")
            #expect(radiiSecond.topTrailing == 0.0, "Second uneven rectangle top trailing radius should be 0.0")
            #expect(styleSecond == .continuous, "Second uneven rectangle rounded corner style should be continuous")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

}
