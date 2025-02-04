//
//  SnappThemingShapeRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import SwiftUI

/// A representation of a button's style shape in the SnappTheming framework.
///
/// This struct defines various button shape types and supports encoding and decoding
/// from JSON for theming purposes.
public enum SnappThemingShapeRepresentation: Codable {
    public enum DecodingError: Error {
        case invalidShape
    }

    enum CodingKeys: String, CodingKey {
        case type
        case style
        case cornerSize
        case cornerRadius
        case cornerRadii
    }

    public struct CornerRadii: Codable, Sendable, Equatable {
        public let topLeading: SnappThemingToken<Double>
        public let bottomLeading: SnappThemingToken<Double>
        public let bottomTrailing: SnappThemingToken<Double>
        public let topTrailing: SnappThemingToken<Double>
    }

    public struct CornerSize: Codable {
        public let width: SnappThemingToken<Double>
        public let height: SnappThemingToken<Double>
    }

    case circle, rectangle, ellipse
    case capsule(SnappThemeingRoundedCornerStyle)
    case roundedRectangleWithRadius(SnappThemingToken<Double>, SnappThemeingRoundedCornerStyle)
    case roundedRectangleWithSize(CornerSize, SnappThemeingRoundedCornerStyle)
    case unevenRoundedRectangle(CornerRadii, SnappThemeingRoundedCornerStyle)

    private enum ShapeType: String, Codable {
        case circle
        case rectangle
        case ellipse
        case capsule
        case roundedRectangle
        case unevenRoundedRectangle
    }

    private var type: ShapeType {
        switch self {
        case .circle: .circle
        case .rectangle: .rectangle
        case .ellipse: .ellipse
        case .capsule: .capsule
        case .roundedRectangleWithRadius, .roundedRectangleWithSize: .roundedRectangle
        case .unevenRoundedRectangle: .unevenRoundedRectangle
        }
    }

    /// Decodes a `SnappThemingShapeRepresentation` from a decoder.
    ///
    /// - Parameter decoder: The decoder used to decode the data.
    /// - Throws: A decoding error if the data is invalid or not formatted as expected.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ShapeType.self, forKey: .type)

        switch type {
        case .circle:
            self = .circle
        case .rectangle:
            self = .rectangle
        case .ellipse:
            self = .ellipse
        case .capsule:
            self = .capsule(try container.decode(SnappThemeingRoundedCornerStyle.self, forKey: .style))
        case .roundedRectangle:
            let style = try container.decode(SnappThemeingRoundedCornerStyle.self, forKey: .style)
            if let cornerRadius = try? container.decode(SnappThemingToken<Double>.self, forKey: .cornerRadius) {
                self = .roundedRectangleWithRadius(cornerRadius, style)
            } else if let cornerSize = try? container.decode(CornerSize.self, forKey: .cornerSize) {
                self = .roundedRectangleWithSize(cornerSize, style)
            } else {
                throw DecodingError.invalidShape
            }
        case .unevenRoundedRectangle:
            let cornerRadii = try container.decode(CornerRadii.self, forKey: .cornerRadii)
            let style = try container.decode(SnappThemeingRoundedCornerStyle.self, forKey: .style)
            self = .unevenRoundedRectangle(cornerRadii, style)
        }
    }

    /// Encodes a `SnappThemingShapeRepresentation` into an encoder.
    ///
    /// - Parameter encoder: The encoder used to encode the data.
    /// - Throws: An encoding error if the data cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)

        switch self {
        case .circle, .rectangle, .ellipse: break
        case .capsule(let style):
            try container.encode(style, forKey: .style)
        case .roundedRectangleWithRadius(let cornerRadius, let style):
            try container.encode(cornerRadius, forKey: .cornerRadius)
            try container.encode(style, forKey: .style)
        case .roundedRectangleWithSize(let size, let style):
            try container.encode(size, forKey: .cornerSize)
            try container.encode(style, forKey: .style)
        case .unevenRoundedRectangle(let radii, let style):
            try container.encode(radii, forKey: .cornerRadii)
            try container.encode(style, forKey: .style)
        }
    }
}
