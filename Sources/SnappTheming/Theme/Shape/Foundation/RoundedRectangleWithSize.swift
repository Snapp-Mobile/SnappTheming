//
//  RoundedRectangleWithSize.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    public struct RoundedRectangleWithSize: Codable, Sendable {
        internal let width: SnappThemingToken<Double>
        internal let height: SnappThemingToken<Double>
        internal let style: RoundedCornerStyleValue

        enum CodingKeys: String, CodingKey {
            case cornerSize, style
        }

        enum CornerSizeCodingKeys: String, CodingKey {
            case width, height
        }

        internal init(width: SnappThemingToken<Double>, height: SnappThemingToken<Double>, styleValue: RoundedCornerStyleValue) {
            self.width = width
            self.height = height
            self.style = styleValue
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
            let cornerSizeContainer = try container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
            self.width = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .width)
            self.height = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .height)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(style, forKey: .style)

            var cornerSizeContainer = container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
            try cornerSizeContainer.encode(width, forKey: .width)
            try cornerSizeContainer.encode(height, forKey: .height)
        }
    }
}
