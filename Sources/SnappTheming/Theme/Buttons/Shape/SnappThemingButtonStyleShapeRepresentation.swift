//
//  SnappThemingButtonStyleShapeRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import SwiftUI

public struct SnappThemingButtonStyleShapeRepresentation: Codable {
    let buttonStyleShape: SnappThemingButtonStyleType

    enum CodingKeys: String, CodingKey {
        case type, value
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tokenType = try container.decode(ButtonStyleShapeType.self, forKey: .type)

        switch tokenType {
        case .circle: buttonStyleShape = .circle
        case .rectangle: buttonStyleShape = .rectangle
        case .ellipse: buttonStyleShape = .ellipse
        case .capsule:
            let styleValue = try container.decode(StyleValue.self, forKey: .value)
            buttonStyleShape = .capsule(styleValue.style.style)
        case .roundedRectangle:
            if let radiusValue = try? container.decodeIfPresent(CornerRadiusValue.self, forKey: .value) {
                buttonStyleShape = .roundedRectangleWithRadius(radiusValue.cornerRadius, radiusValue.styleValue.style)
            } else if let sizeValue = try? container.decodeIfPresent(CornerSizeValue.self, forKey: .value) {
                buttonStyleShape = .roundedRectangleWithSize(sizeValue.cornerSize, sizeValue.styleValue.style)
            } else {
                buttonStyleShape = .rectangle
            }
        case .unevenRoundedRectangle:
            let radiiValue = try container.decode(UnevenRoundedRectangleValue.self, forKey: .value)
            buttonStyleShape = .unevenRoundedRectangle(radiiValue.cornerRadii)
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let tokenType = ButtonStyleShapeType(buttonStyleShape)
        try container.encode(ButtonStyleShapeType(buttonStyleShape).rawValue, forKey: .type)
        switch buttonStyleShape {
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
}

private enum ButtonStyleShapeType: String, Codable {
    case circle
    case rectangle
    case ellipse
    case capsule
    case roundedRectangle
    case unevenRoundedRectangle

    init(_ rawValue: SnappThemingButtonStyleType) {
        switch rawValue {
        case .circle: self = .circle
        case .rectangle: self = .rectangle
        case .ellipse: self = .ellipse
        case .capsule: self = .capsule
        case .unevenRoundedRectangle: self = .unevenRoundedRectangle
        case .roundedRectangleWithRadius, .roundedRectangleWithSize:
            self = .roundedRectangle
        }
    }
}

private struct StyleValue {
    let style: RoundedCornerStyleValue
}
extension StyleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.style = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .style) ?? .continuous
    }
    init(_ rawValue: RoundedCornerStyle) {
        switch rawValue {
        case .continuous: self = .init(style: .continuous)
        case .circular: self = .init(style: .circular)
        @unknown default: self = .init(style: .continuous)
        }
    }
}
private struct CornerRadiusValue {
    let cornerRadius: CGFloat
    let styleValue: RoundedCornerStyleValue
}
extension CornerRadiusValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cornerRadius = try container.decode(CGFloat.self, forKey: .cornerRadius)
        self.styleValue = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
    }
}
private struct CornerSizeValue {
    let cornerSize: CGSize
    let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case cornerSize, styleValue
    }

    enum CornerSizeCodingKeys: String, CodingKey {
        case width, height
    }
}
extension CornerSizeValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.styleValue = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
        let cornerSizeContainer = try container.nestedContainer(keyedBy: CornerSizeCodingKeys.self, forKey: .cornerSize)
        let width = try cornerSizeContainer.decode(CGFloat.self, forKey: .width)
        let height = try cornerSizeContainer.decode(CGFloat.self, forKey: .height)
        self.cornerSize = CGSize(width: width, height: height)
    }
}
private struct UnevenRoundedRectangleValue {
    let cornerRadiiValue: CornerRadiiValue
    let styleValue: RoundedCornerStyleValue

    enum CodingKeys: String, CodingKey {
        case styleValue, cornerRadiiValue = "cornerRadii"
    }

    var cornerRadii: RectangleCornerRadii {
        RectangleCornerRadii(
            topLeading: cornerRadiiValue.topLeading,
            bottomLeading: cornerRadiiValue.bottomLeading,
            bottomTrailing: cornerRadiiValue.bottomTrailing,
            topTrailing: cornerRadiiValue.topTrailing
        )
    }
}
extension UnevenRoundedRectangleValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.styleValue = try container.decodeIfPresent(RoundedCornerStyleValue.self, forKey: .styleValue) ?? .continuous
        self.cornerRadiiValue = try container.decode(CornerRadiiValue.self, forKey: .cornerRadiiValue)
    }
}
private struct CornerRadiiValue {
    let topLeading: CGFloat
    let bottomLeading: CGFloat
    let bottomTrailing: CGFloat
    let topTrailing: CGFloat
}
extension CornerRadiiValue: Codable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.topLeading = try container.decode(CGFloat.self, forKey: .topLeading)
        self.bottomLeading = try container.decode(CGFloat.self, forKey: .bottomLeading)
        self.bottomTrailing = try container.decode(CGFloat.self, forKey: .bottomTrailing)
        self.topTrailing = try container.decode(CGFloat.self, forKey: .topTrailing)
    }
    init(rawValue: RectangleCornerRadii) {
        self.bottomLeading = rawValue.bottomLeading
        self.bottomTrailing = rawValue.bottomTrailing
        self.topLeading = rawValue.topLeading
        self.topTrailing = rawValue.topTrailing
    }
}
private enum RoundedCornerStyleValue: String, Codable {
    case circular, continuous
    var style: RoundedCornerStyle {
        switch self {
        case .circular:
            return .circular
        case .continuous:
            return .continuous
        }
    }

    init(style: RoundedCornerStyle) {
        switch style {
        case .circular:
            self = .circular
        case .continuous:
            self = .continuous
        @unknown default:
            self = .continuous
        }
    }
}
