//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import Testing
import UIKit

@testable import SnappTheming

@Suite
struct FontsTests {
    @Test
    func parseFonts() throws {
        let url = try #require(
            Bundle.module.url(forResource: "fonts", withExtension: "json"), "Fonts JSON should be present")

        let jsonData = try Data(contentsOf: url)
        let json = try #require(String(data: jsonData, encoding: .utf8), "JSON should be readable")

        let declaration = try SnappThemingParser.parse(from: json)
        #expect(declaration.fonts.cache.count == 1)
        let representation = try #require(declaration.fonts.cache["Roboto-Regular"]?.value)
        #expect(representation.postScriptName == "Roboto-Regular")
    }
}
