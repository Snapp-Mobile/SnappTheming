//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import OSLog
import SwiftUI

public enum SnappThemingShapeRepresentation: Codable, Sendable {
    case circle, rectangle, ellipse
    case capsule(CapsuleRepresentation)
    case roundedRectangleWithRadius(RoundedRectangleWithRadius)
    case roundedRectangleWithSize(RoundedRectangleWithSize)
    case unevenRoundedRectangle(UnevenRoundedRectangleRepresentation)

    enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tokenType = try container.decode(String.self, forKey: .type)

        switch tokenType {
        case "circle": self = .circle
        case "rectangle": self = .rectangle
        case "ellipse": self = .ellipse
        case "capsule":
            self = .capsule(try CapsuleRepresentation(from: decoder))
        case "roundedRectangle":
            if let cornerRadiusValue = try? RoundedRectangleWithRadius(from: decoder) {
                self = .roundedRectangleWithRadius(cornerRadiusValue)
            } else if let cornerSizeValue = try? RoundedRectangleWithSize(from: decoder) {
                self = .roundedRectangleWithSize(cornerSizeValue)
            } else {
                os_log(.debug, "Unknown roundedRectangle: %@. Defaulting to Rectangle", tokenType)
                self = .rectangle
            }
        case "unevenRoundedRectangle":
            self = .unevenRoundedRectangle(try UnevenRoundedRectangleRepresentation(from: decoder))

        default:
            os_log(.debug, "Unknown shape type: %@. Defaulting to Rectangle", tokenType)
            self = .rectangle
        }
    }

    /// Encodes a `SnappThemingShapeRepresentation` into an encoder.
    ///
    /// - Parameter encoder: The encoder used to encode the data.
    /// - Throws: An encoding error if the data cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .circle: try container.encode("circle", forKey: .type)
        case .rectangle: try container.encode("rectangle", forKey: .type)
        case .ellipse: try container.encode("ellipse", forKey: .type)
        case .capsule(let style):
            try container.encode("capsule", forKey: .type)
            try style.encode(to: encoder)
        case .roundedRectangleWithRadius(let radiusValue):
            try container.encode("roundedRectangleWithRadius", forKey: .type)
            try radiusValue.encode(to: encoder)
        case .roundedRectangleWithSize(let sizeValue):
            try container.encode("roundedRectangleWithSize", forKey: .type)
            try sizeValue.encode(to: encoder)
        case .unevenRoundedRectangle(let radiiValue):
            try container.encode("unevenRoundedRectangle", forKey: .type)
            try radiiValue.encode(to: encoder)
        }
    }
}
