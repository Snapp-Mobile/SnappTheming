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
    let shapeType: SnappThemingShapeTypeRepresentation

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
            shapeType = .capsule(styleValue)
        case .roundedRectangle:
            if let radiusValue = try? container.decodeIfPresent(CornerRadiusValue.self, forKey: .value) {
                shapeType = .roundedRectangleWithRadius(radiusValue)
            } else if let sizeValue = try? container.decodeIfPresent(CornerSizeValue.self, forKey: .value) {
                shapeType = .roundedRectangleWithSize(sizeValue)
            } else {
                // Fallbacks to rectangle
                shapeType = .rectangle
            }
        case .unevenRoundedRectangle:
            let radiiValue = try container.decode(UnevenRoundedRectangleValue.self, forKey: .value)
            shapeType = .unevenRoundedRectangle(radiiValue)
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
        case .capsule(let style):
            try container.encode(style, forKey: .value)
        case .roundedRectangleWithRadius(let radiusValue):
            try container.encode(radiusValue, forKey: .value)
        case .roundedRectangleWithSize(let sizeValue):
            try container.encode(sizeValue, forKey: .value)
        case .unevenRoundedRectangle(let radiiValue):
            try container.encode(radiiValue, forKey: .value)
        }
    }
}
