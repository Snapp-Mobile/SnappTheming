//
//  CornerSizeValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct CornerSizeValue: Codable {
    internal init(width: SnappThemingToken<Double>, height: SnappThemingToken<Double>, styleValue: RoundedCornerStyleValue) {
        self.width = width
        self.height = height
        self.styleValue = styleValue
    }

    internal let width: SnappThemingToken<Double>
    internal let height: SnappThemingToken<Double>
    private let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case cornerSize
        case styleValue = "style"
    }

    enum CornerSizeCodingKeys: String, CodingKey {
        case width, height
    }

    internal var roundedCornerStyle: RoundedCornerStyle {
        styleValue.style
    }
}

extension CornerSizeValue {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.styleValue =
            try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
        let cornerSizeContainer = try container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
        self.width = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .width)
        self.height = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .height)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(styleValue, forKey: .styleValue)

        var cornerSizeContainer = container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
        try cornerSizeContainer.encode(width, forKey: .width)
        try cornerSizeContainer.encode(height, forKey: .height)
    }
}
