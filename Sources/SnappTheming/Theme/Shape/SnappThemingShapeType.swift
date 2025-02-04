//
//  SnappThemingShapeType.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import OSLog
import SwiftUI

enum SnappThemingShapeTypeRepresentation {
    case circle, rectangle, ellipse
    case capsule(StyleValue = StyleValue(.circular))
    case roundedRectangleWithRadius(CornerRadiusValue)
    case roundedRectangleWithSize(CornerSizeValue)
    case unevenRoundedRectangle(UnevenRoundedRectangleValue)

    // TODO: Resolving function have to go declarations
    func resolve(using configuration: SnappThemingShapeConfiguration) -> SnappThemingShapeType {
        switch self {
        case .circle: return .circle
        case .rectangle: return .rectangle
        case .ellipse: return .ellipse
        case .capsule(let styleValue):
            return .capsule(styleValue.roundedCornerStyle)
        case .roundedRectangleWithRadius(let cornerRadiusValue):
            guard let resolvedCornerRadius = configuration.metrics.resolver.resolve(cornerRadiusValue.cornerRadius) else {
                os_log(.debug, "Failed to resolve corner radius")
                return .roundedRectangleWithRadius(
                    configuration.fallbackCornerRadius,
                    configuration.fallbackRoundedCornerStyle
                )
            }
            return .roundedRectangleWithRadius(
                resolvedCornerRadius,
                cornerRadiusValue.roundedCornerStyle
            )
        case .roundedRectangleWithSize(let cornerSizeValue):
            return .roundedRectangleWithSize(
                cornerSizeValue.cornerSize,
                cornerSizeValue.roundedCornerStyle
            )
        case .unevenRoundedRectangle(let value):
            return .unevenRoundedRectangle(
                value.cornerRadii,
                value.roundedCornerStyle
            )
        }
    }
}

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
    @ShapeBuilder var styleShape: some Shape {
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
