//
//  CornerRadiiValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct CornerRadiiValue {
    let topLeading: CGFloat
    let bottomLeading: CGFloat
    let bottomTrailing: CGFloat
    let topTrailing: CGFloat
}

extension CornerRadiiValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.topLeading = try container.decode(CGFloat.self, forKey: .topLeading)
        self.bottomLeading = try container.decode(CGFloat.self, forKey: .bottomLeading)
        self.bottomTrailing = try container.decode(CGFloat.self, forKey: .bottomTrailing)
        self.topTrailing = try container.decode(CGFloat.self, forKey: .topTrailing)
    }

    init(rawValue: RectangleCornerRadii) {
        self.bottomLeading = rawValue.bottomLeading
        self.bottomTrailing = rawValue.bottomTrailing
        self.topLeading = rawValue.topLeading
        self.topTrailing = rawValue.topTrailing
    }
}
