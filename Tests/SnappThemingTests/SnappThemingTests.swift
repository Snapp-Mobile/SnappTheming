import Testing
@testable import SnappTheming
import UIKit

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
    let declaration = SAThemingDeclaration(
        colorCache: [
            "baseWhite": .value(.hex("FFFFFF")),
            "baseBlack": .value(.hex("000000"))])
    let baseWhite: UIColor = declaration.colors.baseWhite
    let baseBlack: UIColor = declaration.colors.baseBlack
    #expect(baseWhite == UIColor(hex: "FFFFFF", format: .rgba))
    #expect(baseBlack == UIColor(hex: "000000", format: .rgba))
}
