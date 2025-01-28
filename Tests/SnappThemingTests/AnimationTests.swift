//
//  AnimationTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

import Testing

@testable import SnappTheming

@Suite
struct AnimationTests {
    @Test
    func testParsing() throws {
        let json =
            """
            {
                "animations": {
                    "lego": {
                        "type": "lottie",
                        "value": "eyJ2IjoiNC44LjAiLCJtZXRhIjp7ImciOiJMb3R0aWVGaWxlcyBBRSAiLCJhIjoiIiwiayI6IiIsImQiOiIiLCJ0YyI6IiJ9LCJmciI6NjAsImlwIjowLCJvcCI6MTgwLCJ3IjoxMDI0LCJoIjoxMDI0LCJubSI6IkxFR08iLCJkZGQiOjAsImFzc2V0cyI6W10sImxheWVycyI6W3siZGRkIjowLCJpbmQiOjEsInR5Ijo0LCJubSI6IjEgIiwi"
                    }
                }
            }
            """
        let fallbackLottieAnimationData = "no-animation".data(using: .utf8)!
        let configuration = SnappThemingParserConfiguration(
            fallbackLottieAnimationData: fallbackLottieAnimationData
        )

        let declaration = try SnappThemingParser.parse(from: json, using: configuration)

        let animationRepresentation: SnappThemingAnimationRepresentation = try #require(declaration.animations.lego)
        let animationValue: SnappThemingAnimationRepresentation.SnappThemingAnimationValue = declaration.animations.lego
        #expect(animationRepresentation.animation == animationValue)
        #expect(animationValue != .lottie(fallbackLottieAnimationData), "Parsed animation data should not match the fallback data.")
    }

    @Test
    func testFallbackAnimation() throws {
        let json =
            """
            {
                "animations": {
                    "lego": {
                        "type": "lottie",
                        "value": "eyJ2IjoiNC44LjAiLCJtZXRhIjp7ImciOiJMb3R0aWVGaWxlcyBBRSAiLCJhIjoiIiwiayI6IiIsImQiOiIiLCJ0YyI6IiJ9LCJmciI6NjAsImlwIjowLCJvcCI6MTgwLCJ3IjoxMDI0LCJoIjoxMDI0LCJubSI6IkxFR08iLCJkZGQiOjAsImFzc2V0cyI6W10sImxheWVycyI6W3siZGRkIjowLCJpbmQiOjEsInR5Ijo0LCJubSI6IjEgIiwi"
                    }
                }
            }
            """
        let fallbackLottieAnimationData = "no-animation".data(using: .utf8)!
        let configuration = SnappThemingParserConfiguration(
            fallbackLottieAnimationData: fallbackLottieAnimationData
        )

        let declaration = try SnappThemingParser.parse(from: json, using: configuration)

        let animationRepresentation: SnappThemingAnimationRepresentation? = declaration.animations.ball
        let animationValue: SnappThemingAnimationRepresentation.SnappThemingAnimationValue = declaration.animations.ball
        #expect(animationRepresentation == nil)
        #expect(animationValue == .lottie(fallbackLottieAnimationData), "Parsed animation data should match the fallback data.")
    }
}
