import Testing

@testable import SnappTheming

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

@Suite
final class SnappThemingDeclarationTests {
    @Test func parseDeclaration() async throws {
        let json = """
            {
                "colors": {
                    "baseWhite": "#FFF1FF",
                    "baseBlack": "#000001",
                    "textColor": "$colors/baseWhite",
                    "textColorTypo": "$colors/baseB1ack"
                }
            }
            """
        let declaration = try SnappThemingParser.parse(from: json)
        let fallbackConfiguration = declaration.colors.configuration
        try compareEncoded(declaration, and: json)

        #if canImport(UIKit)
            let baseWhite: UIColor = declaration.colors.baseWhite
            let baseBlack: UIColor = declaration.colors.baseBlack
            let textColor: UIColor = declaration.colors.textColor
            let textColorTypo: UIColor = declaration.colors.textColorTypo
            #expect(baseWhite == UIColor(hex: "FFF1FF", format: .rgba))
            #expect(baseBlack == UIColor(hex: "000001", format: .rgba))
            #expect(textColor == UIColor(hex: "FFF1FF", format: .rgba))
            #expect(textColorTypo == fallbackConfiguration.fallbackUIColor)
        #elseif canImport(AppKit)
            let baseWhite: NSColor = declaration.colors.baseWhite
            let baseBlack: NSColor = declaration.colors.baseBlack
            let textColor: NSColor = declaration.colors.textColor
            let textColorTypo: NSColor = declaration.colors.textColorTypo
            #expect(baseWhite == NSColor.fromHex("FFF1FF", using: .rgba))
            #expect(baseBlack == NSColor.fromHex("000001", using: .rgba))
            #expect(textColor == NSColor.fromHex("FFF1FF", using: .rgba))
            #expect(textColorTypo == fallbackConfiguration.fallbackNSColor)
        #endif
    }

    @Test func manualDeclarationCreation() async throws {
        let declaration = SnappThemingDeclaration(
            colorCache: [
                "baseWhite": .value(.hex("FFFFFF")),
                "baseBlack": .value(.hex("000000")),
            ]
        )
        #if canImport(UIKit)
            let baseWhite: UIColor = declaration.colors.baseWhite
            let baseBlack: UIColor = declaration.colors.baseBlack
            #expect(baseWhite == UIColor(hex: "FFFFFF", format: .rgba))
            #expect(baseBlack == UIColor(hex: "000000", format: .rgba))
        #elseif canImport(AppKit)
            let baseWhite: NSColor = declaration.colors.baseWhite
            let baseBlack: NSColor = declaration.colors.baseBlack
            #expect(baseWhite == NSColor.fromHex("FFFFFF", using: .rgba))
            #expect(baseBlack == NSColor.fromHex("000000", using: .rgba))
        #endif
    }

    @Test func overrideDeclaration() async throws {
        let configuration = SnappThemingParserConfiguration.default
        let baseJSON = """
            {
                "colors": {
                    "baseWhite": "#F2FFFF",
                    "baseBlack": "#000000"
                }
            }
            """
        let overrideJSON = """
            {
                "colors": {
                    "baseBlack": "#111111"
                }
            }
            """
        let baseDeclaration = try SnappThemingParser.parse(from: baseJSON, using: configuration)
        try compareEncoded(baseDeclaration, and: baseJSON)
        let overrideDeclaration = try SnappThemingParser.parse(from: overrideJSON, using: configuration)

        let declaration = baseDeclaration.override(with: overrideDeclaration, using: configuration)

        #if canImport(UIKit)
            let baseWhite: UIColor = declaration.colors.baseWhite
            let baseBlack: UIColor = declaration.colors.baseBlack
            #expect(baseWhite == UIColor(hex: "F2FFFF", format: .rgba))
            #expect(baseBlack == UIColor(hex: "111111", format: .rgba))
        #elseif canImport(AppKit)
            let baseWhite: NSColor = declaration.colors.baseWhite
            let baseBlack: NSColor = declaration.colors.baseBlack
            #expect(baseWhite == NSColor.fromHex("F2FFFF", using: .rgba))
            #expect(baseBlack == NSColor.fromHex("111111", using: .rgba))
        #endif
    }
}
