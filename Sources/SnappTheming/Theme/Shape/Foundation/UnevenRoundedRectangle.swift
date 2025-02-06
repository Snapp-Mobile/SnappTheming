//
//  UnevenRoundedRectangle.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    /// Represents an uneven rounded rectangle with customizable corner radii and style.
    ///
    /// This structure supports encoding and decoding of an uneven rounded rectangle,
    /// allowing individual customization of each corner's radius and the corner style.
    public struct UnevenRoundedRectangleRepresentation: Sendable, Codable {
        /// The radii for each corner of the uneven rounded rectangle.
        internal let cornerRadii: CornerRadiiRepresentation
        /// The style of the rounded corners (circular or continuous).
        internal let style: RoundedCornerStyleValue

        internal enum CodingKeys: String, CodingKey {
            case style, cornerRadii
        }

        /// Initializes an `UnevenRoundedRectangleRepresentation` from a decoder.
        ///
        /// - Parameter decoder: The decoder used to decode data.
        /// - Throws: A decoding error if the data is invalid.
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
            self.cornerRadii = try container.decode(CornerRadiiRepresentation.self, forKey: .cornerRadii)
        }

        /// Encodes the `UnevenRoundedRectangleRepresentation` to an encoder.
        ///
        /// - Parameter encoder: The encoder used to encode data.
        /// - Throws: An encoding error if the data cannot be encoded.
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(self.style, forKey: .style)
            try container.encode(self.cornerRadii, forKey: .cornerRadii)
        }
    }
}

extension SnappThemingShapeRepresentation.UnevenRoundedRectangleRepresentation {
    /// Represents the individual corner radii of an uneven rounded rectangle.
    ///
    /// This structure allows specifying different radius values for each corner of
    /// an uneven rounded rectangle.
    public struct CornerRadiiRepresentation: Codable, Sendable {
        /// The radius for the top-leading corner.
        let topLeading: SnappThemingToken<Double>
        /// The radius for the bottom-leading corner.
        let bottomLeading: SnappThemingToken<Double>
        /// The radius for the bottom-trailing corner.
        let bottomTrailing: SnappThemingToken<Double>
        /// The radius for the top-trailing corner.
        let topTrailing: SnappThemingToken<Double>

        enum CodingKeys: String, CodingKey {
            case topLeading, bottomLeading, bottomTrailing, topTrailing
        }
    }
}
