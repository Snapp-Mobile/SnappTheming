//
//  StyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct StyleValue {
    private let _value: RoundedCornerStyleValue

    internal var value: RoundedCornerStyle {
        _value.style
    }

    enum CodingKeys: String, CodingKey {
        case value = "style"
    }
}

extension StyleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._value = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .value) ?? .continuous
    }
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_value, forKey: .value)
    }
}
