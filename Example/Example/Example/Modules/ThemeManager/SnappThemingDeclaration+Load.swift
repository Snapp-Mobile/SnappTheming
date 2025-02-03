//
//  SnappThemingDeclaration+Load.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.02.2025.
//

import OSLog
import SnappTheming

extension SnappThemingDeclaration {
    fileprivate static func empty(using configuration: SnappThemingParserConfiguration)
        -> SnappThemingDeclaration
    {
        SnappThemingDeclaration(using: configuration)
    }

    static func load(
        json: String,
        using configuration: SnappThemingParserConfiguration = .default
    ) -> SnappThemingDeclaration {
        do {
            let declaration = try SnappThemingParser.parse(
                from: json,
                using: configuration)

            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL,
                themeName: configuration.themeName)
            fontManager.registerFonts(declaration.fontInformation)
            return declaration
        } catch let error {
            os_log(
                .error, "Error constructing preview theme: %@",
                error.localizedDescription)
            return .empty(using: configuration)
        }
    }

    static func load(
        filename: String,
        using configuration: SnappThemingParserConfiguration = .default
    ) -> SnappThemingDeclaration {
        guard
            let fileURL = Bundle.main.url(
                forResource: filename, withExtension: "json")
        else {
            os_log(
                .error,
                "Error constructing preview theme: can't find %@.json in resources",
                filename)
            return .empty(using: configuration)
        }
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "{}"
            return .load(json: jsonString, using: configuration)
        } catch {
            os_log(
                .error,
                "Error constructing preview theme: can't read %@.json in resources: %@",
                filename, error.localizedDescription)
            return .empty(using: configuration)
        }
    }

    static let sample: SnappThemingDeclaration = .load(json: sampleJSON)
}
