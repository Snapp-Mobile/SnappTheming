//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import OSLog
import SwiftUI

/// Represents different shape configurations that can be used in theming.
/// This enum supports standard shapes as well as customizable rounded shapes.
public enum SnappThemingShapeRepresentation: Codable, Sendable {
    /// A perfect circle shape.
    case circle
    /// A standard rectangle shape.
    case rectangle
    /// An ellipse shape.
    case ellipse
    /// A capsule shape with specific styling.
    case capsule(CapsuleRepresentation)
    /// A rounded rectangle with a uniform corner radius.
    case roundedRectangleWithRadius(RoundedRectangleWithRadius)
    /// A rounded rectangle where each corner can have a different size.
    case roundedRectangleWithSize(RoundedRectangleWithSize)
    /// A rounded rectangle where each corner can have a unique radius.
    case unevenRoundedRectangle(UnevenRoundedRectangleRepresentation)

    enum CodingKeys: String, CodingKey {
        case type
    }

    enum ShapeType: String, Codable {
        case circle, rectangle, ellipse, capsule, roundedRectangle, unevenRoundedRectangle
    }

    /// Initializes a `SnappThemingShapeRepresentation` from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: A decoding error if the data is corrupted or in an unexpected format.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tokenType = try container.decode(ShapeType.self, forKey: .type)

        switch tokenType {
        case .circle: self = .circle
        case .rectangle: self = .rectangle
        case .ellipse: self = .ellipse
        case .capsule:
            self = .capsule(try CapsuleRepresentation(from: decoder))
        case .roundedRectangle:
            if let cornerRadiusValue = try? RoundedRectangleWithRadius(from: decoder) {
                self = .roundedRectangleWithRadius(cornerRadiusValue)
            } else if let cornerSizeValue = try? RoundedRectangleWithSize(from: decoder) {
                self = .roundedRectangleWithSize(cornerSizeValue)
            } else {
                os_log(.debug, "Unknown roundedRectangle: %@. Defaulting to Rectangle", tokenType.rawValue)
                self = .rectangle
            }
        case .unevenRoundedRectangle:
            self = .unevenRoundedRectangle(try UnevenRoundedRectangleRepresentation(from: decoder))
        }
    }

    /// Encodes a `SnappThemingShapeRepresentation` into an encoder.
    ///
    /// - Parameter encoder: The encoder used to encode the data.
    /// - Throws: An encoding error if the data cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .circle: try container.encode(ShapeType.circle, forKey: .type)
        case .rectangle: try container.encode(ShapeType.rectangle, forKey: .type)
        case .ellipse: try container.encode(ShapeType.ellipse, forKey: .type)
        case .capsule(let style):
            try container.encode(ShapeType.capsule, forKey: .type)
            try style.encode(to: encoder)
        case .roundedRectangleWithRadius(let radiusValue):
            try container.encode(ShapeType.roundedRectangle, forKey: .type)
            try radiusValue.encode(to: encoder)
        case .roundedRectangleWithSize(let sizeValue):
            try container.encode(ShapeType.roundedRectangle, forKey: .type)
            try sizeValue.encode(to: encoder)
        case .unevenRoundedRectangle(let radiiValue):
            try container.encode(ShapeType.unevenRoundedRectangle, forKey: .type)
            try radiiValue.encode(to: encoder)
        }
    }
}
