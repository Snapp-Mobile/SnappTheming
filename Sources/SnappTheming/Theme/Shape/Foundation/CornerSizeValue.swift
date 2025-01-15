//
//  CornerSizeValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation

struct CornerSizeValue {
    let cornerSize: CGSize
    let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case cornerSize, styleValue = "style"
    }

    enum CornerSizeCodingKeys: String, CodingKey {
        case width, height
    }
}

extension CornerSizeValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.styleValue = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
        let cornerSizeContainer = try container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
        let width = try cornerSizeContainer.decode(CGFloat.self, forKey: .width)
        let height = try cornerSizeContainer.decode(CGFloat.self, forKey: .height)
        self.cornerSize = CGSize(width: width, height: height)
    }
}
