//
//  AvailableTheme.swift
//  Example
//
//  Created by Ilian Konchev on 5.12.24.
//

import Foundation
import SnappTheming

enum AvailableTheme: String, Identifiable, CustomStringConvertible, CaseIterable {
    case day, night

    var id: String {
        rawValue
    }

    var description: String {
        switch self {
        case .day:
            return "Day"
        case .night:
            return "Night"
        }
    }

    var url: URL? {
        Bundle.main.url(forResource: rawValue, withExtension: "json")
    }

    var json: String? {
        guard let url = url,
            let data = try? Data(contentsOf: url),
            let json = String(data: data, encoding: .utf8)
        else { return nil }
        return json
    }

    var configuration: SnappThemingParserConfiguration {
        .init(themeName: rawValue)
    }
}
