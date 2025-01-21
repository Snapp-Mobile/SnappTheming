//
//  SnappThemingParser.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import OSLog

/// An error type representing issues encountered during theme parsing.
public enum SnappThemingParserError: Error {
    /// Indicates that the provided data is invalid or cannot be processed.
    case invalidData
}

/// A utility for parsing and encoding theming declarations in JSON format.
public struct SnappThemingParser {
    /// Parses a JSON string into a `SnappThemingDeclaration` object.
    ///
    /// - Parameters:
    ///   - input: A JSON string representing the theming declaration.
    ///   - configuration: A configuration object to customize parsing behavior. Defaults to `.default`.
    /// - Returns: A `SnappThemingDeclaration` object parsed from the input.
    /// - Throws: `SnappThemingParserError.invalidData` if the input string cannot be converted to UTF-8 encoded data.
    /// - Throws: Any decoding errors from `JSONDecoder` during parsing.
    public static func parse(
        from input: String,
        using configuration: SnappThemingParserConfiguration = .default
    ) throws -> SnappThemingDeclaration {
        guard let data = input.data(using: .utf8) else {
            throw SnappThemingParserError.invalidData
        }

        let decoder = JSONDecoder()
        decoder.userInfo[SnappThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration

        // Attempt to decode the JSON data into a `SnappThemingDeclaration`.
        do {
            return try decoder.decode(SnappThemingDeclaration.self, from: data)
        } catch {
            os_log(.error, "Failed to parse JSON: %@", error.localizedDescription)
            throw error
        }
    }

    /// Encodes a `SnappThemingDeclaration` object into JSON data.
    ///
    /// - Parameters:
    ///   - declaration: The `SnappThemingDeclaration` object to encode.
    ///   - configuration: A configuration object to customize encoding behavior. Defaults to `.default`.
    /// - Returns: A JSON-encoded `Data` representation of the declaration.
    /// - Throws: Any encoding errors from `JSONEncoder`.
    public static func encode(
        _ declaration: SnappThemingDeclaration,
        using configuration: SnappThemingParserConfiguration = .default
    ) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.userInfo[SnappThemingDeclaration.themeParserConfigurationUserInfoKey] = configuration

        // Attempt to encode the declaration into JSON data.
        do {
            return try encoder.encode(declaration)
        } catch {
            os_log(.error, "Failed to encode declaration: %@", error.localizedDescription)
            throw error
        }
    }
}
