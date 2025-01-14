//
//  AnimationTests.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

@testable import SnappTheming
import Testing

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

        #expect(declaration.animations.lego.data != fallbackLottieAnimationData, "Parsed animation data should not match the fallback data.")

        if case .lottie = declaration.animations.lego {
            // Test passes if the animation is of type `.lottie`
        } else {
            Issue.record("Animation should be lottie")
        }
    }
}
