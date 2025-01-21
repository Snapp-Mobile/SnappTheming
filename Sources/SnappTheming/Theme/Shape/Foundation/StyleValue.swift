//
//  StyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct StyleValue {
    let style: RoundedCornerStyleValue
}

extension StyleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
    }
    init(_ rawValue: RoundedCornerStyle) {
        switch rawValue {
        case .continuous: self = .init(style: .continuous)
        case .circular: self = .init(style: .circular)
        @unknown default: self = .init(style: .continuous)
        }
    }
}
