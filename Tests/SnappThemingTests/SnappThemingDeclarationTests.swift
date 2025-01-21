import Testing
@testable import SnappTheming
import UIKit

final class SnappThemingDeclarationTests {
    @Test func parseDeclaration() async throws {
        let json = """
        {
            "colors": {
                "baseWhite": "#FFFFFF",
                "baseBlack": "#000000"
            }
        }
        """
        let declaration = try SnappThemingParser.parse(from: json)
        let baseWhite: UIColor = declaration.colors.baseWhite
        let baseBlack: UIColor = declaration.colors.baseBlack
        #expect(baseWhite == UIColor(hex: "FFFFFF", format: .rgba))
        #expect(baseBlack == UIColor(hex: "000000", format: .rgba))
    }
    
    @Test func manualDeclarationCreation() async throws {
        let declaration = SnappThemingDeclaration(
            colorCache: [
                "baseWhite": .value(.hex("FFFFFF")),
                "baseBlack": .value(.hex("000000"))
            ]
        )
        let baseWhite: UIColor = declaration.colors.baseWhite
        let baseBlack: UIColor = declaration.colors.baseBlack
        #expect(baseWhite == UIColor(hex: "FFFFFF", format: .rgba))
        #expect(baseBlack == UIColor(hex: "000000", format: .rgba))
    }
    
    @Test func overrideDeclaration() async throws {
        let configuration = SnappThemingParserConfiguration.default
        let baseJSON = """
        {
            "colors": {
                "baseWhite": "#FFFFFF",
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
        let overrideDeclaration = try SnappThemingParser.parse(from: overrideJSON, using: configuration)
        
        let declaration = baseDeclaration.override(with: overrideDeclaration, using: configuration)
        
        let baseWhite: UIColor = declaration.colors.baseWhite
        let baseBlack: UIColor = declaration.colors.baseBlack
        #expect(baseWhite == UIColor(hex: "FFFFFF", format: .rgba))
        #expect(baseBlack == UIColor(hex: "111111", format: .rgba))
    }
}
