//
//  FontsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import Testing
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

        let robotoFontInformation: SnappThemingFontInformation = try #require(declaration.fonts[dynamicMember: "Roboto-Regular"])
        let robotoFontSource = try #require(robotoFontInformation.source)
        let robotoFontResolver: SnappThemingFontResolver = declaration.fonts[dynamicMember: "Roboto-Regular"]

        let helveticaFontInformation: SnappThemingFontInformation = try #require(declaration.fonts[dynamicMember: "Helvetica"])
        let helveticaFontResolver: SnappThemingFontResolver = declaration.fonts[dynamicMember: "Helvetica"]

        #expect(robotoFontInformation.postScriptName == "Roboto-Regular")
        #expect(robotoFontSource.type == .truetypeTTFFont)
        #expect(robotoFontResolver != .system)

        #expect(helveticaFontInformation.postScriptName == "Helvetica")
        #expect(helveticaFontInformation.source == nil)
        #expect(helveticaFontResolver != .system)
    }

    @Test
    func useFallbackFont() throws {
        let json = "{}"
        let declaration = try SnappThemingParser.parse(from: json)
        try compareEncoded(declaration, and: json)
        let fontInformation: SnappThemingFontInformation? = declaration.fonts[dynamicMember: "Roboto-Regular"]
        let fontResolver: SnappThemingFontResolver = declaration.fonts[dynamicMember: "Roboto-Regular"]

        #expect(fontInformation == nil)
        #expect(fontResolver == .system)
    }
}

extension UTType {
    fileprivate static let truetypeTTFFont: UTType = .init("public.truetype-ttf-font")!
}
