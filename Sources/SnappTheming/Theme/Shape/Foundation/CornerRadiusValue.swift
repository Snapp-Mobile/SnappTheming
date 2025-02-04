//
//  CornerRadiusValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct CornerRadiusValue {
    internal init(_ token: SnappThemingToken<Double>, styleValue: RoundedCornerStyleValue) {
        self.token = token
        self.styleValue = styleValue
    }

    internal let token: SnappThemingToken<Double>
    private let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case token = "cornerRadius"
        case styleValue = "style"
    }

    internal var roundedCornerStyle: RoundedCornerStyle {
        styleValue.style
    }
}

extension CornerRadiusValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(SnappThemingToken<Double>.self, forKey: .token)
        self.styleValue =
            try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
    }
}
