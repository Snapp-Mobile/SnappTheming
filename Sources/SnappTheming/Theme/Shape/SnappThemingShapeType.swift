//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.02.2025.
//

import SwiftUI

public enum SnappThemingShapeType: Equatable, Sendable {
    case circle, rectangle, ellipse
    case capsule(RoundedCornerStyle)
    case roundedRectangleWithRadius(CGFloat, RoundedCornerStyle)
    case roundedRectangleWithSize(CGSize, RoundedCornerStyle)
    case unevenRoundedRectangle(RectangleCornerRadii, RoundedCornerStyle)

    /// Resolves the interactive color information into an interactive color resolver, which provides resolved colors for the various states.
    ///
    /// - Parameters:
    ///   - colorFormat: The color format to use (e.g., ARGB, RGBA).
    ///   - colors: The color declarations used to resolve the color tokens.
    /// - Returns: A `SnappThemingInteractiveColorResolver` that provides the resolved interactive colors.
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
