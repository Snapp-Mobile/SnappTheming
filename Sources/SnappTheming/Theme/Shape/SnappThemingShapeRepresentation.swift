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
public struct SnappThemingShapeRepresentation: Codable {
    /// The button style shape type (e.g., circle, rectangle, capsule).
    public let shapeType: SnappThemingShapeType

    enum CodingKeys: String, CodingKey {
        case type, value
    }

    /// Decodes a `SnappThemingShapeRepresentation` from a decoder.
    ///
    /// - Parameter decoder: The decoder used to decode the data.
    /// - Throws: A decoding error if the data is invalid or not formatted as expected.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tokenType = try container.decode(SnappThemingButtonStyleShapeType.self, forKey: .type)

        switch tokenType {
        case .circle: shapeType = .circle
        case .rectangle: shapeType = .rectangle
        case .ellipse: shapeType = .ellipse
        case .capsule:
            let styleValue = try container.decode(StyleValue.self, forKey: .value)
            shapeType = .capsule(styleValue.style.style)
        case .roundedRectangle:
            if let radiusValue = try? container.decodeIfPresent(CornerRadiusValue.self, forKey: .value) {
                shapeType = .roundedRectangleWithRadius(radiusValue.cornerRadius, radiusValue.styleValue.style)
            } else if let sizeValue = try? container.decodeIfPresent(CornerSizeValue.self, forKey: .value) {
                shapeType = .roundedRectangleWithSize(sizeValue.cornerSize, sizeValue.styleValue.style)
            } else {
                shapeType = .rectangle
            }
        case .unevenRoundedRectangle:
            let radiiValue = try container.decode(UnevenRoundedRectangleValue.self, forKey: .value)
            shapeType = .unevenRoundedRectangle(radiiValue.cornerRadii, radiiValue.styleValue.style)
        }
    }

    /// Encodes a `SnappThemingShapeRepresentation` into an encoder.
    ///
    /// - Parameter encoder: The encoder used to encode the data.
    /// - Throws: An encoding error if the data cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let tokenType = SnappThemingButtonStyleShapeType(shapeType)
        try container.encode(tokenType.rawValue, forKey: .type)

        switch shapeType {
        case .circle, .rectangle, .ellipse: break
        case let .capsule(style):
            try container.encode(StyleValue(style), forKey: .value)
        case let .roundedRectangleWithRadius(radius, style):
            try container.encode(CornerRadiusValue(cornerRadius: radius, styleValue: RoundedCornerStyleValue(style: style)), forKey: .value)
        case let .roundedRectangleWithSize(size, style):
            try container.encode(CornerSizeValue(cornerSize: size, styleValue: RoundedCornerStyleValue(style: style)), forKey: .value)
        case let .unevenRoundedRectangle(radii, style):
            try container.encode(UnevenRoundedRectangleValue(cornerRadiiValue: CornerRadiiValue(rawValue: radii), styleValue: RoundedCornerStyleValue(style: style)), forKey: .value)
        }
    }

    /// Resolves the button style shape and returns a resolver object for further theming logic.
    ///
    /// - Returns: A `SnappThemingShapeResolver` instance that resolves the button's shape style.
    func resolver() -> SnappThemingShapeResolver {
        SnappThemingShapeResolver(shapeType: shapeType)
    }
}
