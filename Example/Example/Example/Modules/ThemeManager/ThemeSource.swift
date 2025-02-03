//
//  ThemeSource.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.02.2025.
//

import Foundation

enum ThemeSource: String, Hashable, CaseIterable, RawRepresentable {
    static let `default` = light

    case light

    var filename: String { rawValue }
    var title: String { rawValue.capitalized }

    init(rawValue: String) {
        self =
            Self.allCases.first(where: {
                $0.rawValue == rawValue
            }) ?? .default
    }
}
