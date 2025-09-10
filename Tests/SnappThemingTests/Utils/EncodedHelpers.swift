//
//  EncodedHelpers.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import Foundation
import SnappTheming
import Testing

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
