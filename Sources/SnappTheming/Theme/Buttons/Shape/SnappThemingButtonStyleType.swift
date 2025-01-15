//
//  SnappThemingButtonStyleType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import SwiftUI

/// Represents the different types of button styles that can be applied in the theming system.
///
/// - `circle`:  A circular button style.
/// - `rectangle`:  A rectangular button style.
/// - `ellipse`:  An elliptical button style.
/// - `capsule`:  A capsule-shaped button with customizable rounded corners.
/// - `roundedRectangleWithRadius`:  A rounded rectangle with a specified corner radius.
/// - `roundedRectangleWithSize`:  A rounded rectangle with a specified corner size.
/// - `unevenRoundedRectangle`:  A rectangle with uneven corner radii.
public enum SnappThemingButtonStyleType: Sendable {
    case circle, rectangle, ellipse
    case capsule(RoundedCornerStyle = .continuous)
    case roundedRectangleWithRadius(CGFloat, RoundedCornerStyle = .continuous)
    case roundedRectangleWithSize(CGSize, RoundedCornerStyle = .continuous)
    case unevenRoundedRectangle(RectangleCornerRadii, RoundedCornerStyle = .continuous)

    /// Provides the shape representation of the button style.
    /// This will return the appropriate `Shape` (e.g., `Circle`, `Rectangle`, `Capsule`).
    @ShapeBuilder
    public var value: some Shape {
        styleShape
    }

    /// Retrieves the corner radius associated with the button style.
    /// - Returns: A `CGFloat` representing the corner radius.
    public var cornerRadius: CGFloat {
        switch self {
        case .circle, .ellipse, .capsule: return 1000
        case .rectangle: return 0
        case let .roundedRectangleWithRadius(radius, _):
            return radius
        case let .roundedRectangleWithSize(size, _):
            return size.width
        case let .unevenRoundedRectangle(radii, _):
            return radii.topLeading
        }
    }

    /// A computed property that returns the corresponding `Shape` for the button style.
    /// - Returns: A `Shape` instance that corresponds to the button style type.
    @ShapeBuilder var styleShape: some Shape {
        switch self {
        case .circle:
            Circle()
        case .rectangle:
            Rectangle()
        case .ellipse:
            Ellipse()
        case let .capsule(style):
            Capsule(style: style)
        case let .roundedRectangleWithRadius(radius, style):
            RoundedRectangle(cornerRadius: radius, style: style)
        case let .roundedRectangleWithSize(size, style):
            RoundedRectangle(cornerSize: size, style: style)
        case let .unevenRoundedRectangle(radii, style):
            UnevenRoundedRectangle(cornerRadii: radii, style: style)
        }
    }
}
