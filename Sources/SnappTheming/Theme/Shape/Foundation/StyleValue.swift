//
//  StyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct StyleValue {
    private let value: RoundedCornerStyleValue

    internal var roundedCornerStyle: RoundedCornerStyle {
        value.style
    }

    enum CodingKeys: String, CodingKey {
        case value = "style"
    }
}

extension StyleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .value) ?? .continuous
    }
    init(_ rawValue: RoundedCornerStyle) {
        switch rawValue {
        case .continuous: self = .init(value: .continuous)
        case .circular: self = .init(value: .circular)
        @unknown default: self = .init(value: .continuous)
        }
    }
}
