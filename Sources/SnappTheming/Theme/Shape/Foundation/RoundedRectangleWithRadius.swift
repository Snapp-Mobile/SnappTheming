//
//  RoundedRectangleWithRadius.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    /// Represents a rounded rectangle with a configurable corner radius and style.
    ///
    /// This structure provides encoding and decoding capabilities for a rounded rectangle
    /// shape, allowing customization of its corner radius and rounded corner style.
    public struct RoundedRectangleWithRadius: Sendable, Codable {
        /// The corner radius of the rounded rectangle.
        let cornerRadius: SnappThemingToken<Double>
        /// The style of the rounded corners (circular or continuous).
        let style: RoundedCornerStyleValue

        enum CodingKeys: String, CodingKey {
            case cornerRadius
            case style
        }

        /// Initializes a `RoundedRectangleWithRadius` from a decoder.
        ///
        /// - Parameter decoder: The decoder to decode data from.
        /// - Throws: A decoding error if the data is invalid.
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.cornerRadius = try container.decode(SnappThemingToken<Double>.self, forKey: .cornerRadius)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
        }

        /// Encodes the `RoundedRectangleWithRadius` to an encoder.
        ///
        /// - Parameter encoder: The encoder to encode data into.
        /// - Throws: An encoding error if the data cannot be encoded.
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.cornerRadius, forKey: .cornerRadius)
            try container.encodeIfPresent(self.style, forKey: .style)
        }
    }
}
