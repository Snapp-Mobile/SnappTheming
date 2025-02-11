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
                    "baseBlack": "#000000"
                }
            }
            """
        let declaration = try SnappThemingParser.parse(from: json)
        try compareEncoded(declaration, and: json)

        #if canImport(UIKit)
            let baseWhite: UIColor = declaration.colors.baseWhite
            let baseBlack: UIColor = declaration.colors.baseBlack
            #expect(baseWhite == UIColor(hex: "FFF1FF", format: .rgba))
            #expect(baseBlack == UIColor(hex: "000000", format: .rgba))
        #elseif canImport(AppKit)
            let baseWhite: NSColor = declaration.colors.baseWhite
            let baseBlack: NSColor = declaration.colors.baseBlack
            #expect(baseWhite == NSColor.fromHex("FFF1FF", using: .rgba))
            #expect(baseBlack == NSColor.fromHex("000000", using: .rgba))
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

func compareEncoded(_ declaration: SnappThemingDeclaration, and json: String) throws {
    let jsonData = Data(json.utf8)
    let declarationData = try JSONEncoder().encode(declaration)

    // Normalize both JSONs
    let normalizedJSON1 = try normalizeJSON(jsonData)
    let normalizedJSON2 = try normalizeJSON(declarationData)

    // Compare normalized strings
    #expect(normalizedJSON1 == normalizedJSON2)
}

/// Converts JSON `Data` into a normalized, sorted string representation
func normalizeJSON(_ data: Data) throws -> String {
    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
    let normalizedData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.sortedKeys])
    return String(data: normalizedData, encoding: .utf8) ?? ""
}
