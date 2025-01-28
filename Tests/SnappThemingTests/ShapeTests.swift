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
        switch shapeRepresentation.shapeType {
        case .rectangle:
            #expect(Bool(true))
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
        switch shapeRepresentation.shapeType {
        case .ellipse:
            #expect(Bool(true))
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
        switch shapeRepresentation.shapeType {
        case .circle:
            #expect(Bool(true))
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
        switch (circularCapsuleShapeRepresentation.shapeType, continuousCapsuleShapeRepresentation.shapeType) {
        case (.capsule(let styleFirst), .capsule(let styleSecond)):
            #expect(
                styleFirst == .circular
                    && styleSecond == .continuous
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test
    func parseRoundedRectanglesWithRadius() throws {
        let json =
            """
            {
                "shapes": {
                    "roundedRectangle": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerRadius": 12,
                            "style": "circular"
                        }
                    },
                    "roundedRectangleAlt": {
                        "type": "roundedRectangle",
                        "value": {
                            "cornerRadius": 24,
                            "style": "continuous"
                        }
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        switch (declaration.shapes.roundedRectangle?.shapeType, declaration.shapes.roundedRectangleAlt?.shapeType) {
        case (
            .roundedRectangleWithRadius(let radiusFirst, let styleFirst),
            .roundedRectangleWithRadius(let radiusSecond, let styleSecond)
        ):
            #expect(
                radiusFirst == 12
                    && styleFirst == .circular
                    && radiusSecond == 24
                    && styleSecond == .continuous
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
        switch (declaration.shapes.roundedRectangle?.shapeType, declaration.shapes.roundedRectangleAlt?.shapeType) {
        case (
            .roundedRectangleWithSize(let sizeFirst, let styleFirst),
            .roundedRectangleWithSize(let sizeSecond, let styleSecond)
        ):
            #expect(
                sizeFirst.width == 15.0
                    && sizeFirst.height == 30.0
                    && styleFirst == .circular
                    && sizeSecond.width == 30.0
                    && sizeSecond.height == 60.0
                    && styleSecond == .continuous
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
        switch (declaration.shapes.funkyRect?.shapeType, declaration.shapes.funkyRectAlt?.shapeType) {
        case (
            .unevenRoundedRectangle(let radiiFirst, let styleFirst),
            .unevenRoundedRectangle(let radiiSecond, let styleSecond)
        ):
            #expect(
                radiiFirst.topLeading == 0.0
                    && radiiFirst.bottomLeading == 20.0
                    && radiiFirst.bottomTrailing == 0.0
                    && radiiFirst.topTrailing == 20.0
                    && styleFirst == .circular
                    && radiiSecond.topLeading == 20.0
                    && radiiSecond.bottomLeading == 0.0
                    && radiiSecond.bottomTrailing == 20.0
                    && radiiSecond.topTrailing == 0.0
                    && styleSecond == .continuous
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

}
