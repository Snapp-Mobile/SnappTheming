//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import OSLog
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
public enum SnappThemingShapeType: Sendable, Equatable {
    case circle, rectangle, ellipse
    case capsule(RoundedCornerStyle)
    case roundedRectangleWithRadius(CGFloat, RoundedCornerStyle)
    case roundedRectangleWithSize(CGSize, RoundedCornerStyle)
    case unevenRoundedRectangle(RectangleCornerRadii, RoundedCornerStyle)

    /// Retrieves the corner radius associated with the button style.
    /// - Returns: A `CGFloat` representing the corner radius.
    public var cornerRadius: CGFloat {
        switch self {
        case .circle, .ellipse, .capsule: return 1000
        case .rectangle: return 0
        case .roundedRectangleWithRadius(let radius, _):
            return radius
        case .roundedRectangleWithSize(let size, _):
            return size.width
        case .unevenRoundedRectangle(let radii, _):
            return radii.topLeading
        }
    }

    /// A computed property that returns the corresponding `Shape` for the button style.
    /// - Returns: A `Shape` instance that corresponds to the button style type.
    @ShapeBuilder var shape: some Shape {
        switch self {
        case .circle:
            Circle()
        case .rectangle:
            Rectangle()
        case .ellipse:
            Ellipse()
        case .capsule(let style):
            Capsule(style: style)
        case .roundedRectangleWithRadius(let radius, let style):
            RoundedRectangle(cornerRadius: radius, style: style)
        case .roundedRectangleWithSize(let size, let style):
            RoundedRectangle(cornerSize: size, style: style)
        case .unevenRoundedRectangle(let radii, let style):
            UnevenRoundedRectangle(cornerRadii: radii, style: style)
        }
    }
}
