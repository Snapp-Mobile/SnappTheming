//
//  RoundedRectangleWithSize.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    /// Represents a rounded rectangle with configurable width, height, and corner style.
    ///
    /// This structure provides encoding and decoding capabilities for a rounded rectangle
    /// shape, allowing customization of its corner size (width and height) and rounded
    /// corner style.
    public struct RoundedRectangleWithSize: Codable, Sendable {
        /// The width of the rounded rectangle's corner.
        internal let width: SnappThemingToken<Double>
        /// The height of the rounded rectangle's corner.
        internal let height: SnappThemingToken<Double>
        /// The style of the rounded corners (circular or continuous).
        internal let style: RoundedCornerStyleValue

        enum CodingKeys: String, CodingKey {
            case cornerSize, style
        }

        enum CornerSizeCodingKeys: String, CodingKey {
            case width, height
        }

        /// Initializes a `RoundedRectangleWithSize` with specified parameters.
        ///
        /// - Parameters:
        ///   - width: The width of the rounded rectangle's corner.
        ///   - height: The height of the rounded rectangle's corner.
        ///   - styleValue: The style of the rounded corners.
        internal init(width: SnappThemingToken<Double>, height: SnappThemingToken<Double>, styleValue: RoundedCornerStyleValue) {
            self.width = width
            self.height = height
            self.style = styleValue
        }

        /// Initializes a `RoundedRectangleWithSize` from a decoder.
        ///
        /// - Parameter decoder: The decoder to decode data from.
        /// - Throws: A decoding error if the data is invalid.
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous

            let cornerSizeContainer = try container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
            self.width = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .width)
            self.height = try cornerSizeContainer.decode(SnappThemingToken<Double>.self, forKey: .height)
        }

        /// Encodes the `RoundedRectangleWithSize` to an encoder.
        ///
        /// - Parameter encoder: The encoder to encode data into.
        /// - Throws: An encoding error if the data cannot be encoded.
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(style, forKey: .style)

            var cornerSizeContainer = container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
            try cornerSizeContainer.encode(width, forKey: .width)
            try cornerSizeContainer.encode(height, forKey: .height)
        }
    }
}
