//
//  UnevenRoundedRectangleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct UnevenRoundedRectangleValue {
    let cornerRadiiValue: CornerRadiiValue
    let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case styleValue = "style"
        case cornerRadiiValue = "cornerRadii"
    }

    var cornerRadii: RectangleCornerRadii {
        RectangleCornerRadii(
            topLeading: cornerRadiiValue.topLeading,
            bottomLeading: cornerRadiiValue.bottomLeading,
            bottomTrailing: cornerRadiiValue.bottomTrailing,
            topTrailing: cornerRadiiValue.topTrailing
        )
    }
}

extension UnevenRoundedRectangleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let value = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue)
        self.styleValue = value ?? .continuous
        self.cornerRadiiValue = try container.decode(CornerRadiiValue.self, forKey: .cornerRadiiValue)
    }
}
