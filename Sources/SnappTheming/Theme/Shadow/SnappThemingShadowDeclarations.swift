//
//  SnappThemingShadowDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import Foundation

/// A type alias for shadow-specific theming declarations.
///
/// This provides a convenient way to work with shadow theming declarations that use
/// ``SnappThemingShadowRepresentation`` as the declared value type and
/// ``SnappThemingShadowConfiguration`` as the configuration type.
public typealias SnappThemingShadowDeclarations = SnappThemingDeclarations<
    SnappThemingShadowRepresentation,
    SnappThemingShadowConfiguration
>

extension SnappThemingShadowDeclarations
where
    DeclaredValue == SnappThemingShadowRepresentation,
    Configuration == SnappThemingShadowConfiguration
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration = .default,
        metrics: SnappThemingMetricDeclarations,
        colors: SnappThemingColorDeclarations
    ) {
        self.init(
            cache: cache,
            rootKey: .shadows,
            configuration: Configuration(
                fallbackColor: configuration.fallbackShadow.color,
                fallbackRadius: configuration.fallbackShadow.radius,
                fallbackX: configuration.fallbackShadow.x,
                fallbackY: configuration.fallbackShadow.y,
                fallbackSpread: configuration.fallbackShadow.spread,
                metrics: metrics,
                colors: colors,
                colorFormat: configuration.colorFormat
            )
        )
    }

    /// Dynamically resolves a shadow token using dot notation and returns a shadow resolver.
    ///
    /// This subscript enables accessing shadow tokens using dynamic member lookup syntax.
    /// It attempts to resolve all shadow properties (color, radius, x, y, spread) and
    /// returns a ``SnappThemingShadowResolver`` with either the resolved values or fallback values.
    ///
    /// ### Usage
    /// ```swift
    /// let cardShadow = shadowDeclarations.card.elevated
    /// let shadowColor = cardShadow.color
    /// let shadowRadius = cardShadow.radius
    /// ```
    ///
    /// - Parameter keyPath: The dot-separated path to the desired shadow token.
    /// - Returns: A ``SnappThemingShadowResolver`` containing the resolved or fallback shadow properties.
    ///
    /// - Note: If any shadow property cannot be resolved, all properties fall back to the configured fallback values.
    public subscript(dynamicMember keyPath: String) -> SnappThemingShadowResolver {
        guard
            let representation: DeclaredValue = self[dynamicMember: keyPath],
            let resolvedColor = configuration.colors.resolver.resolve(representation.color)?
                .color(using: configuration.colorFormat),
            let resolvedRadius = configuration.metrics.resolver.resolve(representation.radius),
            let resolvedX = configuration.metrics.resolver.resolve(representation.x),
            let resolvedY = configuration.metrics.resolver.resolve(representation.y),
            let resolvedSpread = configuration.metrics.resolver.resolve(representation.spread)
        else {
            return SnappThemingShadowResolver(
                color: configuration.fallbackColor,
                radius: configuration.fallbackRadius,
                x: configuration.fallbackX,
                y: configuration.fallbackY,
                spread: configuration.fallbackSpread
            )
        }

        return SnappThemingShadowResolver(
            color: resolvedColor,
            radius: resolvedRadius,
            x: resolvedX,
            y: resolvedY,
            spread: resolvedSpread
        )
    }
}
