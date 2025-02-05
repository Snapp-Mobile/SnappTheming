//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.02.2025.
//

import SwiftUI

/// Represents different types of shapes that can be used in theming.
public enum SnappThemingShapeType: Equatable, Sendable {
    /// A perfect circle shape.
    case circle
    /// A standard rectangular shape.
    case rectangle
    /// An ellipse shape, which can be stretched in one or both directions.
    case ellipse
    /// A capsule shape, with fully rounded ends.
    /// - Parameter style: The corner style of the capsule.
    case capsule(RoundedCornerStyle)
    /// A rounded rectangle with a specified corner radius.
    /// - Parameters:
    ///   - radius: The corner radius for the rectangle.
    ///   - style: The corner style of the rectangle.
    case roundedRectangleWithRadius(CGFloat, RoundedCornerStyle)
    /// A rounded rectangle with specific corner sizes.
    /// - Parameters:
    ///   - size: The size of the corners for the rectangle.
    ///   - style: The corner style of the rectangle.
    case roundedRectangleWithSize(CGSize, RoundedCornerStyle)
    /// A rectangle with unevenly rounded corners.
    /// - Parameters:
    ///   - radii: The different corner radii for each corner.
    ///   - style: The corner style of the rectangle.
    case unevenRoundedRectangle(RectangleCornerRadii, RoundedCornerStyle)

    /// Generates the corresponding SwiftUI `Shape` representation based on the selected shape type.
    @ShapeBuilder public var shape: some Shape {
        switch self {
        case .circle:
            Circle()
        case .rectangle:
            Rectangle()
        case .ellipse:
            Ellipse()
        case .capsule(let style):
            Capsule(style: style)
        case .roundedRectangleWithRadius(let cornerRadius, let style):
            RoundedRectangle(cornerRadius: cornerRadius, style: style)
        case .roundedRectangleWithSize(let cornerSize, let style):
            RoundedRectangle(cornerSize: cornerSize, style: style)
        case .unevenRoundedRectangle(let radii, let style):
            UnevenRoundedRectangle(cornerRadii: radii, style: style)
        }
    }
}
