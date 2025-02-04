//
//  SnappThemingShapeDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import OSLog
import SwiftUI

/// Manages button shape tokens, defining the appearance of button outlines, such as circular, rounded rectangle, or custom shapes.
public typealias SnappThemingShapeDeclarations = SnappThemingDeclarations<
    SnappThemingShapeRepresentation,
    SnappThemingShapeConfiguration
>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingShapeRepresentation,
    Configuration == SnappThemingShapeConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        metrics: SnappThemingMetricDeclarations,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(
            cache: cache,
            rootKey: .shapes,
            configuration: Configuration(
                fallbackShape: configuration.fallbackButtonStyle.shape,
                fallbackCornerRadius: configuration.fallbackCornerRadius,
                fallbackRoundedCornerStyle: configuration
                    .fallbackRoundedCornerStyle,
                fallbackCornerRadii: configuration.fallbackCornerRadii,
                themeConfiguration: configuration,
                metrics: metrics
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingShapeType {
        if let representation: DeclaredValue = cache[keyPath]?.value {
            configuration.resolve(representation)
        } else {
            configuration.fallbackShape
        }
    }

    public subscript(dynamicMember keyPath: String) -> some Shape {
        let shapeType: SnappThemingShapeType = self[dynamicMember: keyPath]
        return shapeType.shape
    }
}

extension SnappThemingShapeConfiguration {
    func resolve(_ representation: SnappThemingShapeRepresentation) -> SnappThemingShapeType {
        switch representation {
        case .circle: return .circle
        case .rectangle: return .rectangle
        case .ellipse: return .ellipse
        case .capsule(.circular):
            return .capsule(.circular)
        case .capsule(.continuous):
            return .capsule(.continuous)
        case .roundedRectangleWithRadius(let cornerRadius, let style):
            guard
                let cornerRadius = metrics.resolver
                    .resolve(cornerRadius)
            else {
                os_log(
                    .debug,
                    "Failed to resolve corner radius for shape")
                return .roundedRectangleWithRadius(
                    fallbackCornerRadius,
                    fallbackRoundedCornerStyle
                )
            }
            return .roundedRectangleWithRadius(
                cornerRadius.cgFloat,
                style.swiftUIStyle)
        case .roundedRectangleWithSize(let size, let style):
            guard
                let width = metrics.resolver.resolve(
                    size.width),
                let height = metrics.resolver.resolve(
                    size.height)
            else {
                os_log(
                    .debug,
                    "Failed to resolve corner size for shape")
                return .roundedRectangleWithSize(
                    CGSize(
                        width: fallbackCornerRadius,
                        height: fallbackCornerRadius),
                    fallbackRoundedCornerStyle
                )
            }
            return .roundedRectangleWithSize(
                CGSize(width: width, height: height),
                style.swiftUIStyle)
        case .unevenRoundedRectangle(let radii, let style):
            guard
                let topLeading = metrics.resolver.resolve(
                    radii.topLeading),
                let bottomLeading = metrics.resolver.resolve(
                    radii.bottomLeading),
                let topTrailing = metrics.resolver.resolve(
                    radii.topTrailing),
                let bottomTrailing = metrics.resolver.resolve(
                    radii.bottomTrailing)
            else {
                os_log(
                    .debug,
                    "Failed to resolve corner radii")
                return .unevenRoundedRectangle(
                    fallbackCornerRadii,
                    fallbackRoundedCornerStyle
                )
            }
            return .unevenRoundedRectangle(
                RectangleCornerRadii(
                    topLeading: topLeading.cgFloat,
                    bottomLeading: bottomLeading.cgFloat,
                    bottomTrailing: bottomTrailing.cgFloat,
                    topTrailing: topTrailing.cgFloat),
                style.swiftUIStyle
            )
        }
    }
}

extension SnappThemeingRoundedCornerStyle {
    fileprivate var swiftUIStyle: RoundedCornerStyle {
        switch self {
        case .continuous:
            return .continuous
        case .circular:
            return .circular
        }
    }
}
