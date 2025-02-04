//
//  SnappThemingShapeRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 12.12.2024.
//

import OSLog
import SwiftUI

/// A representation of a button's style shape in the SnappTheming framework.
///
/// This struct defines various button shape types and supports encoding and decoding
/// from JSON for theming purposes.
public struct SnappThemingShapeRepresentation: Codable {
    /// The button style shape type (e.g., circle, rectangle, capsule).
    let shapeType: SnappThemingShapeTypeRepresentation

    public init(from decoder: any Decoder) throws {
        self.shapeType = try SnappThemingShapeTypeRepresentation(from: decoder)
    }

    /// Resolves the interactive color information into an interactive color resolver, which provides resolved colors for the various states.
    ///
    /// - Parameters:
    ///   - colorFormat: The color format to use (e.g., ARGB, RGBA).
    ///   - colors: The color declarations used to resolve the color tokens.
    /// - Returns: A `SnappThemingInteractiveColorResolver` that provides the resolved interactive colors.
    @ShapeBuilder public func resolver(
        configuration: SnappThemingShapeConfiguration
    ) -> some Shape {
        switch shapeType {
        case .circle:
            Circle()
        case .rectangle:
            Rectangle()
        case .ellipse:
            Ellipse()
        case .capsule(let cornerStyle):
            Capsule(style: cornerStyle.value)
        case .roundedRectangleWithRadius(let cornerRadius):
            roundedRectangleWithRadius(cornerRadiusValue: cornerRadius, configuration)
        case .roundedRectangleWithSize(let size):
            roundedRectangleWithSize(size, configuration)
        case .unevenRoundedRectangle(let radii):
            unevenRoundedRectangle(radii, configuration)
        }
    }

    private func roundedRectangleWithRadius(
        cornerRadiusValue: CornerRadiusValue,
        _ configuration: SnappThemingShapeConfiguration
    ) -> RoundedRectangle {
        guard
            let resolvedCornerRadius = configuration.metrics.resolver
                .resolve(cornerRadiusValue.token)
        else {
            os_log(.debug, "Failed to resolve corner radius: %@", "\(cornerRadiusValue.token)")
            return RoundedRectangle(
                cornerRadius: configuration.fallbackCornerRadius, style: configuration.fallbackRoundedCornerStyle
            )
        }
        return RoundedRectangle(
            cornerRadius: resolvedCornerRadius, style: cornerRadiusValue.roundedCornerStyle
        )
    }

    private func roundedRectangleWithSize(
        _ sizeToken: CornerSizeValue,
        _ configuration: SnappThemingShapeConfiguration
    ) -> RoundedRectangle {
        guard let width = configuration.metrics.resolver.resolve(sizeToken.width),
            let height = configuration.metrics.resolver.resolve(sizeToken.height)
        else {
            os_log(.debug, "Failed to resolve corner size: w-%@, h-%@", "\(sizeToken.width)", "\(sizeToken.height)")
            return RoundedRectangle(
                cornerSize: CGSize(width: configuration.fallbackCornerRadius, height: configuration.fallbackCornerRadius),
                style: configuration.fallbackRoundedCornerStyle
            )
        }
        return RoundedRectangle(
            cornerSize: CGSize(width: width, height: height),
            style: sizeToken.roundedCornerStyle
        )
    }

    private func unevenRoundedRectangle(
        _ uneven: UnevenRoundedRectangleValue,
        _ configuration: SnappThemingShapeConfiguration
    ) -> UnevenRoundedRectangle {
        guard
            let topLeading = configuration.metrics.resolver.resolve(
                uneven.cornerRadiiValue.topLeading),
            let bottomLeading = configuration.metrics.resolver.resolve(
                uneven.cornerRadiiValue.bottomLeading),
            let topTrailing = configuration.metrics.resolver.resolve(
                uneven.cornerRadiiValue.topTrailing),
            let bottomTrailing = configuration.metrics.resolver.resolve(
                uneven.cornerRadiiValue.bottomTrailing)
        else {
            os_log(.debug, "Failed to resolve corner radii: %@", "\(uneven.cornerRadiiValue)")
            return UnevenRoundedRectangle(
                cornerRadii: configuration.fallbackCornerRadii, style: configuration.fallbackRoundedCornerStyle
            )
        }
        var cornerRadii: RectangleCornerRadii {
            RectangleCornerRadii(
                topLeading: topLeading,
                bottomLeading: bottomLeading,
                bottomTrailing: bottomTrailing,
                topTrailing: topTrailing
            )
        }
        return UnevenRoundedRectangle(
            cornerRadii: cornerRadii, style: uneven.roundedCornerStyle
        )
    }
}
