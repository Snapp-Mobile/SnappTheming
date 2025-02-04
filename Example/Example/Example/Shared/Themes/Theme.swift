//
//  Theme.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.02.2025.
//

import Foundation
import OSLog
import SnappTheming

@Observable
@dynamicMemberLookup
final class Theme {
    private static let themeSourceFileNameKey = "theme_filename"

    struct Source: RawRepresentable, Identifiable, Hashable,
        CustomStringConvertible, ExpressibleByStringLiteral
    {
        let filename: String

        var description: String { filename.capitalized }
        var rawValue: String { filename }
        var id: String { filename }

        init(filename: String) {
            self.filename = filename
        }

        init(rawValue value: String) {
            self.init(filename: value)
        }

        init(stringLiteral value: StringLiteralType) {
            self.init(rawValue: value)
        }
    }

    var source: Source {
        didSet {
            _declaration = nil
        }
    }

    var availableSources: [Source] { Source.allCases }

    var declaration: SnappThemingDeclaration {
        if let declaration = _declaration {
            return declaration
        }

        let declaration = source.loadDeclaration()
        _declaration = declaration
        return declaration
    }

    var encoded: String {
        if let encoded = _encoded {
            return encoded
        }
        let encoded = declaration.encoded(using: encodingParserConfiguration)
        _encoded = encoded
        return encoded
    }

    private var _declaration: SnappThemingDeclaration? {
        didSet {
            _encoded = nil
        }
    }
    private var _encoded: String?

    private let encodingParserConfiguration: SnappThemingParserConfiguration =
        .init(encodeImages: true)

    init(_ source: Source) {
        self.source = source
    }

    convenience init() {
        let source =
            UserDefaults.standard
            .string(forKey: Self.themeSourceFileNameKey)
            .map(Source.init(rawValue:)) ?? nil
        self.init(source ?? .default)
    }

    func change(_ source: Source) {
        self.source = source
    }

    subscript<Value>(
        dynamicMember keyPath: KeyPath<SnappThemingDeclaration, Value>
    ) -> Value {
        declaration[keyPath: keyPath]
    }
}

extension Theme.Source {
    fileprivate func loadDeclaration() -> SnappThemingDeclaration {
        .load(filename: filename, using: .init(themeName: filename))
    }
}

extension Theme.Source {
    static let `default`: Self = .light

    static let light: Self = "light"
    static let dark: Self = "dark"
}

extension Theme.Source: CaseIterable {
    static let allCases: [Theme.Source] = [.light, .dark]
}

extension SnappThemingDeclaration {
    fileprivate static func empty(
        using configuration: SnappThemingParserConfiguration
    )
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
                .error, "Error loading theme: %@",
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
                "Error loading theme: can't find %@.json in resources",
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
                "Error loading theme: can't read %@.json in resources: %@",
                filename, error.localizedDescription)
            return .empty(using: configuration)
        }
    }

    static let sample: SnappThemingDeclaration = .load(json: sampleJSON)

    func encoded(using configuration: SnappThemingParserConfiguration) -> String
    {
        do {
            let encodedOutput = try SnappThemingParser.encode(
                self, using: configuration)
            let encoded = String(data: encodedOutput, encoding: .utf8)
            return encoded ?? "Failed to decode to string"
        } catch let error {
            os_log(.error, "Error: %@", error.localizedDescription)
            return error.localizedDescription
        }
    }
}
