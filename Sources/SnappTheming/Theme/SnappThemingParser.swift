//
//  SnappThemingParser.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation

public enum SnappThemingParserError: Error {
    case invalidData
}

public struct SnappThemingParser {
    public static func parse(
        from input: String,
        using configuration: SnappThemingParserConfiguration = .default
    ) throws -> SnappThemingDeclaration {
        guard let data = input.data(using: .utf8) else {
            throw SnappThemingParserError.invalidData
        }
        let decoder = JSONDecoder()
        decoder.userInfo[SnappThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration
        return try decoder.decode(SnappThemingDeclaration.self, from: data)
    }

    public static func encode(
        _ declaration: SnappThemingDeclaration,
        using configuration: SnappThemingParserConfiguration = .default
    ) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.userInfo[SnappThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration
        return try encoder.encode(declaration)
    }
}
