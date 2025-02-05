//
//  RoundedRectangleWithRadius.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    public struct RoundedRectangleWithRadius: Sendable, Codable {
        let cornerRadius: SnappThemingToken<Double>
        let style: RoundedCornerStyleValue

        enum CodingKeys: String, CodingKey {
            case cornerRadius
            case style
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.cornerRadius = try container.decode(SnappThemingToken<Double>.self, forKey: .cornerRadius)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.cornerRadius, forKey: .cornerRadius)
            try container.encodeIfPresent(self.style, forKey: .style)
        }
    }
}
