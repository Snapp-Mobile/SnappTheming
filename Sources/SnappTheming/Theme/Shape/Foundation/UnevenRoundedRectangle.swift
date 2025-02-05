//
//  UnevenRoundedRectangle.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    public struct UnevenRoundedRectangleRepresentation: Sendable, Codable {
        internal let cornerRadii: CornerRadiiRepresentation
        internal let style: RoundedCornerStyleValue

        internal enum CodingKeys: String, CodingKey {
            case style, cornerRadii
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let styleValue = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style)
            self.style = styleValue ?? .continuous
            self.cornerRadii = try container.decode(CornerRadiiRepresentation.self, forKey: .cornerRadii)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(self.style, forKey: .style)
            try container.encode(self.cornerRadii, forKey: .cornerRadii)
        }
    }
}
extension SnappThemingShapeRepresentation.UnevenRoundedRectangleRepresentation {
    struct CornerRadiiRepresentation: Codable, Sendable {
        let topLeading: SnappThemingToken<Double>
        let bottomLeading: SnappThemingToken<Double>
        let bottomTrailing: SnappThemingToken<Double>
        let topTrailing: SnappThemingToken<Double>

        enum CodingKeys: String, CodingKey {
            case topLeading, bottomLeading, bottomTrailing, topTrailing
        }
    }
}
