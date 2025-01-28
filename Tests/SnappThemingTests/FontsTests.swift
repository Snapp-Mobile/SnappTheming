//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import Testing
import UIKit
import UniformTypeIdentifiers

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
        let fontInformation: SnappThemingFontInformation = try #require(declaration.fonts[dynamicMember: "Roboto-Regular"])
        let fontResolver: SnappThemingFontResolver = declaration.fonts[dynamicMember: "Roboto-Regular"]

        #expect(fontInformation.postScriptName == "Roboto-Regular")
        #expect(fontInformation.source.type == .truetypeTTFFont)
        #expect(fontResolver != .system)
    }

    @Test
    func useFallbackFont() throws {
        let declaration = try SnappThemingParser.parse(from: "{}")
        let fontInformation: SnappThemingFontInformation? = declaration.fonts[dynamicMember: "Roboto-Regular"]
        let fontResolver: SnappThemingFontResolver = declaration.fonts[dynamicMember: "Roboto-Regular"]

        #expect(fontInformation == nil)
        #expect(fontResolver == .system)
    }
}

extension UTType {
    fileprivate static let truetypeTTFFont: UTType = .init("public.truetype-ttf-font")!
}
