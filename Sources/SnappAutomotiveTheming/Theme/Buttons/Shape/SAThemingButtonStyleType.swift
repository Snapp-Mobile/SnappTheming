//
//  SAThemingButtonStyleType.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import SwiftUI

public enum SAThemingButtonStyleType: Sendable {
    case circle, rectangle, ellipse
    case capsule(RoundedCornerStyle = .continuous)
    case roundedRectangleWithRadius(CGFloat, RoundedCornerStyle = .continuous)
    case roundedRectangleWithSize(CGSize, RoundedCornerStyle = .continuous)
    case unevenRoundedRectangle(RectangleCornerRadii, RoundedCornerStyle = .continuous)

    public var value: AnyShape {
        AnyShape(styleShape)
    }
    var styleShape: any Shape {
        switch self {
        case .circle: return Circle()
        case .rectangle: return Rectangle()
        case .ellipse: return Ellipse()
        case let .capsule(style):
            return Capsule(style: style)
        case let .roundedRectangleWithRadius(radius, style):
            return RoundedRectangle(cornerRadius: radius, style: style)
        case let .roundedRectangleWithSize(size, style):
            return RoundedRectangle(cornerSize: size, style: style)
        case let .unevenRoundedRectangle(radii, style):
            return UnevenRoundedRectangle(cornerRadii: radii, style: style)
        }
    }
}
