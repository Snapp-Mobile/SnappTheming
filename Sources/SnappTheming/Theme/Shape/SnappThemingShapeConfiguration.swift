//
//  SnappThemingShapeConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import OSLog
import SwiftUI

/// A configuration structure for button style shapes in the SnappTheming framework.
///
/// This struct defines the fallback shape for a button style, providing a default
/// shape configuration in case a specific shape is not available.
public struct SnappThemingShapeConfiguration {
    /// The fallback shape to use when no specific shape is provided.
    public let fallbackShape: SnappThemingShapeType

    /// The default corner radius applied when the shape supports rounded corners.
    public let fallbackCornerRadius: Double

    /// The rounded corner style used when applicable.
    public let fallbackRoundedCornerStyle: RoundedCornerStyle

    public let fallbackCornerRadii: RectangleCornerRadii

    let themeConfiguration: SnappThemingParserConfiguration
    let metrics: SnappThemingMetricDeclarations
}

extension SnappThemingShapeConfiguration {
    func resolve(_ representation: SnappThemingShapeRepresentation)
        -> SnappThemingShapeType
    {
        switch representation {
        case .circle: .circle
        case .rectangle: .rectangle
        case .ellipse: .ellipse
        case .capsule(let capsule): .capsule(capsule.style.roundedCornerStyle)
        case .roundedRectangleWithRadius(let roundedRectangleWithRadius):
            roundedRectangleWithRadiusType(roundedRectangleWithRadius)
        case .roundedRectangleWithSize(let roundedRectangleWithSize):
            roundedRectangleWithSizeType(roundedRectangleWithSize)
        case .unevenRoundedRectangle(let unevenRoundedRectangle):
            unevenRoundedRectangleType(unevenRoundedRectangle)
        }
    }

    private func roundedRectangleWithRadiusType(
        _ roundedRectWithRadius: SnappThemingShapeRepresentation.RoundedRectangleWithRadius
    ) -> SnappThemingShapeType {
        guard let resolvedRadius = metrics.resolver.resolve(roundedRectWithRadius.cornerRadius) else {
            os_log(.debug, "Failed to resolve corner radius: %@", "\(roundedRectWithRadius.cornerRadius)")
            return .roundedRectangleWithRadius(fallbackCornerRadius, fallbackRoundedCornerStyle)
        }
        let roundedStyle = roundedRectWithRadius.style.roundedCornerStyle
        return .roundedRectangleWithRadius(resolvedRadius, roundedStyle)
    }

    private func roundedRectangleWithSizeType(
        _ roundedRectangleWithSizeRepresentation: SnappThemingShapeRepresentation.RoundedRectangleWithSize
    ) -> SnappThemingShapeType {
        guard let resolvedWidth = metrics.resolver.resolve(roundedRectangleWithSizeRepresentation.width),
            let resolvedHeight = metrics.resolver.resolve(roundedRectangleWithSizeRepresentation.height)
        else {
            os_log(
                .debug, "Failed to resolve corner size: w-%@, h-%@",
                "\(roundedRectangleWithSizeRepresentation.width)",
                "\(roundedRectangleWithSizeRepresentation.height)")
            let fallbackSize = CGSize(width: fallbackCornerRadius, height: fallbackCornerRadius)
            return .roundedRectangleWithSize(fallbackSize, fallbackRoundedCornerStyle)
        }
        let resolvedSize = CGSize(width: resolvedWidth, height: resolvedHeight)
        let roundedCornerStyle = roundedRectangleWithSizeRepresentation.style.roundedCornerStyle
        return .roundedRectangleWithSize(resolvedSize, roundedCornerStyle)
    }

    private func unevenRoundedRectangleType(
        _ unevenRoundedRectangle: SnappThemingShapeRepresentation
            .UnevenRoundedRectangleRepresentation
    ) -> SnappThemingShapeType {
        guard let topLeading = metrics.resolver.resolve(unevenRoundedRectangle.cornerRadii.topLeading),
            let bottomLeading = metrics.resolver.resolve(unevenRoundedRectangle.cornerRadii.bottomLeading),
            let topTrailing = metrics.resolver.resolve(unevenRoundedRectangle.cornerRadii.topTrailing),
            let bottomTrailing = metrics.resolver.resolve(unevenRoundedRectangle.cornerRadii.bottomTrailing)
        else {
            os_log(.debug, "Failed to resolve corner radii: %@", "\(unevenRoundedRectangle.cornerRadii)")
            return .unevenRoundedRectangle(fallbackCornerRadii, fallbackRoundedCornerStyle)
        }
        var resolvedCornerRadii: RectangleCornerRadii {
            RectangleCornerRadii(
                topLeading: topLeading,
                bottomLeading: bottomLeading,
                bottomTrailing: bottomTrailing,
                topTrailing: topTrailing
            )
        }
        let roundedCornerStyle = unevenRoundedRectangle.style.roundedCornerStyle
        return .unevenRoundedRectangle(resolvedCornerRadii, roundedCornerStyle)
    }
}
