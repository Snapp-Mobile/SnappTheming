//
//  SnappThemingAnimationRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

import Foundation

/// A representation of an animation configuration for theming purposes.
///
/// This struct supports decoding and encoding animation definitions,
/// specifically for Lottie animations. Animations are represented as
/// Base64-encoded data, stored under specific animation types.
///
/// Example JSON:
/// ```json
/// {
///     "animations": {
///         "lego": {
///             "type": "lottie",
///             "value": "eyJ2IjoiNC44LjAiLCJtZXRh...."
///         }
///     }
/// }
/// ```
///
/// - Supported Animation Types:
///     - `lottie`: Uses Base64-encoded data to represent Lottie animations.
public struct SnappThemingAnimationRepresentation: Codable {
    /// Enum defining the types of animations supported.
    public enum SnappThemingAnimationType: String, Codable {
        case lottie
    }

    /// Enum defining the value for an animation.
    public enum SnappThemingAnimationValue: Codable {
        /// Represents Lottie animation data.
        case lottie(Data)

        /// Provides the raw data for the animation.
        public var data: Data {
            switch self {
            case .lottie(let data):
                return data
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case type, value
    }

    /// Error enum for decoding failures.
    private enum DecodingError: Error {
        case invalidData
    }

    /// The animation value, which includes the type and its data.
    public let animation: SnappThemingAnimationValue

    /// Decodes an instance of `SnappThemingAnimationRepresentation` from a decoder.
    ///
    /// - Parameter decoder: The decoder to decode from.
    /// - Throws: An error if the data is invalid or cannot be decoded.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tokenType = try container.decode(SnappThemingAnimationType.self, forKey: .type)

        switch tokenType {
        case .lottie:
            let base64string = try container.decode(String.self, forKey: .value)

            guard
                let base64EncodedData = base64string.data(using: .utf8),
                let data = Data(base64Encoded: base64EncodedData)
            else {
                throw DecodingError.invalidData
            }

            animation = .lottie(data)
        }
    }

    /// Encodes an instance of `SnappThemingAnimationRepresentation` to an encoder.
    ///
    /// - Parameter encoder: The encoder to encode to.
    /// - Throws: An error if the data cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch animation {
        case .lottie(let data):
            try container.encode(SnappThemingAnimationType.lottie, forKey: .type)
            try container.encode(data.base64EncodedString(), forKey: .value)
        }
    }
}

extension SnappThemingAnimationRepresentation.SnappThemingAnimationType {
    init(_ animation: SnappThemingAnimationRepresentation.SnappThemingAnimationValue) {
        switch animation {
        case .lottie:
            self = .lottie
        }
    }
}
