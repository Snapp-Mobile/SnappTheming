//
//  SAThemingParser.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation

public enum SAThemeParserError: Error {
    case invalidData
}

public struct SAThemingParser {
    public static func parse(
        from input: String,
        using configuration: SAThemingParserConfiguration = .default
    ) throws -> SAThemingDeclaration {
        guard let data = input.data(using: .utf8) else {
            throw SAThemeParserError.invalidData
        }
        let decoder = JSONDecoder()
        decoder.userInfo[SAThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration
        return try decoder.decode(SAThemingDeclaration.self, from: data)
    }

    public static func encode(
        _ declaration: SAThemingDeclaration,
        using configuration: SAThemingParserConfiguration = .default
    ) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.userInfo[SAThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration
        return try encoder.encode(declaration)
    }
}
