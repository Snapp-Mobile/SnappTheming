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
        try compareEncoded(declaration, and: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.rect)
        let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
        let _ = resolvedShape.shape
        switch resolvedShape {
        case .rectangle:
            let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
            #expect(resolvedShape == .rectangle)
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
        try compareEncoded(declaration, and: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.ellipse)
        let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
        let _ = resolvedShape.shape
        switch resolvedShape {
        case .ellipse:
            let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
            #expect(resolvedShape == .ellipse)
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
        try compareEncoded(declaration, and: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.circle)
        let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
        let _ = resolvedShape.shape
        switch resolvedShape {
        case .circle:
            let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
            #expect(resolvedShape == .circle)
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
        try compareEncoded(declaration, and: json)
        let circularCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(
            declaration.shapes.circularCapsule)
        let continuousCapsuleShapeRepresentation: SnappThemingShapeRepresentation = try #require(
            declaration.shapes.continuousCapsule)

        let resolvedShape1 = declaration.shapes.configuration.resolve(circularCapsuleShapeRepresentation)
        let _ = resolvedShape1.shape
        let resolvedShape2 = declaration.shapes.configuration.resolve(continuousCapsuleShapeRepresentation)
        let _ = resolvedShape2.shape

        switch (resolvedShape1, resolvedShape2) {
        case (.capsule(let styleFirst), .capsule(let styleSecond)):
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

        let resolvedShape1 = fallbackConfiguration.resolve(firstShapeRepresentation)
        let _ = resolvedShape1.shape
        let resolvedShape2 = fallbackConfiguration.resolve(secondShapeRepresentation)
        let _ = resolvedShape2.shape
        let resolvedShape3 = fallbackConfiguration.resolve(thirdShapeRepresentation)
        let _ = resolvedShape3.shape

        switch (resolvedShape1, resolvedShape2, resolvedShape3) {
        case (
            .roundedRectangleWithRadius(let radius1, let style1),
            .roundedRectangleWithRadius(let radius2, let style2),
            .roundedRectangleWithRadius(let radius3, let style3)
        ):
            #expect(radius1 == 12, "First radius should be 12")
            #expect(style1 == .circular, "First style should be circular")
            #expect(radius2 == 24, "Second radius should be 24")
            #expect(style2 == .continuous, "Second style should be continuous")
            #expect(radius3 == fallbackConfiguration.fallbackCornerRadius.cgFloat)
            #expect(style3 == fallbackConfiguration.fallbackRoundedCornerStyle)
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
                    },
                    "roundedRectangleWithBrokenAliases": {
                        "type": "roundedRectangle",
                        "cornerSize": {
                            "width": 30,
                            "height": "$metrics/wrongAlias"
                        },
                        "style": "continuous"
                    }
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.shapes.configuration
        let roundedRectangleShapeRepresentation: SnappThemingShapeRepresentation = try #require(
            declaration.shapes.roundedRectangle)
        let roundedRectangleAltShapeRepresentation: SnappThemingShapeRepresentation = try #require(
            declaration.shapes.roundedRectangleAlt)
        let roundedRectangleWithBrokenAliases: SnappThemingShapeRepresentation = try #require(
            declaration.shapes.roundedRectangleWithBrokenAliases)

        let resolvedShape1 = fallbackConfiguration.resolve(roundedRectangleShapeRepresentation)
        let _ = resolvedShape1.shape
        let resolvedShape2 = fallbackConfiguration.resolve(roundedRectangleAltShapeRepresentation)
        let _ = resolvedShape2.shape
        let resolvedShape3 = fallbackConfiguration.resolve(roundedRectangleWithBrokenAliases)
        let _ = resolvedShape3.shape

        switch (resolvedShape1, resolvedShape2, resolvedShape3) {
        case (
            .roundedRectangleWithSize(let size1, let style1),
            .roundedRectangleWithSize(let size2, let style2),
            .roundedRectangleWithSize(let size3, let style3)
        ):
            #expect(size1.width == 15.0, "First rounded rectangle width should be 15.0")
            #expect(size1.height == 30.0, "First rounded rectangle height should be 30.0")
            #expect(style1 == .circular, "First rounded rectangle rounded corner style should be circular")
            #expect(size2.width == 30.0, "Second rounded rectangle width should be 30.0")
            #expect(size2.height == 60.0, "Second rounded rectangle height should be 60.0")
            #expect(style2 == .continuous, "Second rounded rectangle rounded corner style should be continuous")
            #expect(
                size3.width == fallbackConfiguration.fallbackCornerRadius.cgFloat,
                "Third rounded rectangle height should use fallback configuration"
            )
            #expect(
                size3.height == fallbackConfiguration.fallbackCornerRadius.cgFloat,
                "Third rounded rectangle height should use fallback configuration"
            )
            #expect(
                style3 == fallbackConfiguration.fallbackRoundedCornerStyle,
                "Third rounded rectangle rounded corner style should use fallback configuration"
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
                "metrics": {
                    "largeSpace": 60
                },
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
                            "bottomLeading": "$metrics/largeSpace",
                            "bottomTrailing": 70,
                            "topTrailing": 80
                        },
                        "style": "continuous"
                    },
                    "funkyRectWithBrokenAliases": {
                        "type": "unevenRoundedRectangle",
                        "cornerRadii": {
                            "topLeading": 50,
                            "bottomLeading": "$metrics/laRgeSpace",
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
        let funkyRectShapeRepresentation = try #require(declaration.shapes.funkyRect)
        let funkyRectAltShapeRepresentation = try #require(declaration.shapes.funkyRectAlt)
        let funkyRectWithBrokenAliasesShapeRepresentation = try #require(declaration.shapes.funkyRectWithBrokenAliases)

        let resolvedShape1 = fallbackConfiguration.resolve(funkyRectShapeRepresentation)
        let _ = resolvedShape1.shape
        let resolvedShape2 = fallbackConfiguration.resolve(funkyRectAltShapeRepresentation)
        let _ = resolvedShape2.shape
        let resolvedShape3 = fallbackConfiguration.resolve(funkyRectWithBrokenAliasesShapeRepresentation)
        let _ = resolvedShape3.shape

        switch (resolvedShape1, resolvedShape2, resolvedShape3) {
        case (
            .unevenRoundedRectangle(let radii1, let style1),
            .unevenRoundedRectangle(let radii2, let style2),
            .unevenRoundedRectangle(let radii3, let style3)
        ):
            #expect(radii1.topLeading == 10.0, "First uneven rectangle top leading radius should be 10.0")
            #expect(radii1.bottomLeading == 20.0, "First uneven rectangle bottom leading radius should be 20.0")
            #expect(radii1.bottomTrailing == 30.0, "First uneven rectangle bottom trailing radius should be 30.0")
            #expect(radii1.topTrailing == 40.0, "First uneven rectangle top trailing radius should be 40.0")
            #expect(style1 == .circular, "First uneven rectangle rounded corner style should be circular")

            #expect(radii2.topLeading == 50.0, "Second uneven rectangle top leading radius should be 50.0")
            #expect(radii2.bottomLeading == 60.0, "Second uneven rectangle bottom leading radius should be 60.0")
            #expect(radii2.bottomTrailing == 70.0, "Second uneven rectangle bottom trailing radius should be 70.0")
            #expect(radii2.topTrailing == 80.0, "Second uneven rectangle top trailing radius should be 80.0")
            #expect(style2 == .continuous, "Second uneven rectangle rounded corner style should be continuous")

            #expect(
                radii3.topLeading == fallbackConfiguration.fallbackCornerRadii.topLeading,
                "Third uneven rectangle top leading radius should use fallback")
            #expect(
                radii3.bottomLeading == fallbackConfiguration.fallbackCornerRadii.bottomLeading,
                "Third uneven rectangle bottom leading radius should use fallback")
            #expect(
                radii3.bottomTrailing == fallbackConfiguration.fallbackCornerRadii.bottomTrailing,
                "Third uneven rectangle bottom trailing radius should use fallback")
            #expect(
                radii3.topTrailing == fallbackConfiguration.fallbackCornerRadii.topTrailing,
                "Third uneven rectangle top trailing radius should use fallback")
            #expect(
                style3 == fallbackConfiguration.fallbackRoundedCornerStyle,
                "Third uneven rectangle rounded corner style should be use fallback"
            )
        default:
            throw ShapeParserError.invalidShapeType
        }
    }

    @Test(arguments: [
        """
        {
            "shapes": {
                "rect": {
                    "type": "roundedRectangle" 
                }
            }
        }
        """
    ])
    func parseUnknownShape(json: String) throws {
        let declaration = try SnappThemingParser.parse(from: json)
        let shapeRepresentation: SnappThemingShapeRepresentation = try #require(declaration.shapes.rect)
        let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
        let _ = resolvedShape.shape
        switch resolvedShape {
        case .rectangle:
            let resolvedShape = declaration.shapes.configuration.resolve(shapeRepresentation)
            #expect(resolvedShape == .rectangle, "Default shape type should be rectangle")
        default:
            throw ShapeParserError.invalidShapeType
        }
    }
}
