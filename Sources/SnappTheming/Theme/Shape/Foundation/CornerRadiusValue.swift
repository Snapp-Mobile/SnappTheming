//
//  CornerRadiusValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation

struct CornerRadiusValue {
    let cornerRadius: CGFloat
    let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case cornerRadius
        case styleValue = "style"
    }
}

extension CornerRadiusValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cornerRadius = try container.decode(CGFloat.self, forKey: .cornerRadius)
        self.styleValue =
            try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
    }
}
