import SwiftUI
import Testing

@testable import SnappTheming

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

@Suite
final class ShadowTests {
    @Test func parseDeclaration() async throws {
        let json = """
            {
                "shadows": {
                    "thin": {
                        "color": "#FFF1FF",
                        "radius": 2,
                        "x": -1,
                        "y": 3,
                        "spread": 0.25,
                    },
                    "thick": {
                        "color": "#000001",
                        "radius": 5,
                        "x": 2,
                        "y": -2,
                        "spread": -1.25,
                    },
                    "primary": "$shadows/thin",
                    "secondary": "$shadows/thick"
                }
            }
            """
        let configuration = SnappThemingParserConfiguration.default
        let declaration = try SnappThemingParser.parse(from: json, using: configuration)
        let fallbackConfiguration = declaration.shadows.configuration

        try compareEncoded(declaration, and: json)

        let thin: SnappThemingShadowResolver = declaration.shadows.thin
        let thick: SnappThemingShadowResolver = declaration.shadows.thick
        let primary: SnappThemingShadowResolver = declaration.shadows.primary
        let secondary: SnappThemingShadowResolver = declaration.shadows.secondary

        let typo: SnappThemingShadowResolver = declaration.shadows.typo

        #expect(thin.radius == 2.0)
        #expect(thick.radius == 5.0)
        #expect(primary.radius == 2.0)
        #expect(secondary.radius == 5.0)

        #expect(typo.radius == fallbackConfiguration.fallbackRadius)

        #expect(thin.x == -1.0)
        #expect(thick.x == 2.0)
        #expect(primary.x == -1.0)
        #expect(secondary.x == 2.0)

        #expect(typo.x == fallbackConfiguration.fallbackX)

        #expect(thin.y == 3.0)
        #expect(thick.y == -2.0)
        #expect(primary.y == 3.0)
        #expect(secondary.y == -2.0)

        #expect(typo.y == fallbackConfiguration.fallbackY)

        #expect(thin.spread == 0.25)
        #expect(thick.spread == -1.25)
        #expect(primary.spread == 0.25)
        #expect(secondary.spread == -1.25)

        #expect(typo.spread == fallbackConfiguration.fallbackSpread)

        #expect(thin.color == Color(hex: "#FFF1FF"))
        #expect(thick.color == Color(hex: "000001"))
        #expect(primary.color == Color(hex: "FFF1FF"))
        #expect(secondary.color == Color(hex: "000001"))

        #expect(typo.color == fallbackConfiguration.fallbackColor)
    }
}
