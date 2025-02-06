//
//  CapsuleRepresentation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    /// A representation of a capsule shape with a configurable corner style.
    ///
    /// This structure allows encoding and decoding of a capsule's corner style,
    /// defaulting to `.continuous` if no style is specified.
    public struct CapsuleRepresentation: Sendable, Codable {
        /// The corner style of the capsule.
        internal let style: RoundedCornerStyleValue

        enum CodingKeys: String, CodingKey {
            case style
        }

        /// Initializes a `CapsuleRepresentation` from a decoder.
        ///
        /// - Parameter decoder: The decoder to decode data from.
        /// - Throws: A decoding error if the data is invalid.
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
        }

        /// Encodes the `CapsuleRepresentation` to an encoder.
        ///
        /// - Parameter encoder: The encoder to encode data into.
        /// - Throws: An encoding error if the data cannot be encoded.
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(style, forKey: .style)
        }
    }
}
