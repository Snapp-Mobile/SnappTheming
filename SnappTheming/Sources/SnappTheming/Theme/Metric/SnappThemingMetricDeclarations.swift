//
//  SnappThemingMetricDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation

/// Handles numeric tokens, such as spacing, corner radius, border widths. Useful for creating a consistent design language with reusable measurements.
public typealias SnappThemingMetricDeclarations = SnappThemingDeclarations<Double, SnappThemingMetricConfiguration>

/// Configuration for resolving metrics in the SnappTheming framework.
public struct SnappThemingMetricConfiguration {
    /// Fallback metric value to use when a specific metric cannot be resolved.
    public let fallbackMetric: CGFloat
}

extension SnappThemingDeclarations where DeclaredValue == Double, Configuration == SnappThemingMetricConfiguration {
    /// Initializes the declarations for themed metrics.
    /// - Parameters:
    ///   - cache: A cache of metric tokens keyed by their identifiers.
    ///   - configuration: The parser configuration used to define fallback behavior.
    public init(cache: [String: SnappThemingToken<Double>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .metrics,
            configuration: .init(
                fallbackMetric: configuration.fallbackMetric
            )
        )
    }

    /// Dynamically resolves a metric value using a key path.
    /// - Parameter keyPath: The key path used to identify the desired metric.
    /// - Returns: The resolved metric as a `CGFloat`, or the fallback metric if resolution fails.
    public subscript(dynamicMember keyPath: String) -> CGFloat {
        guard let representation: Double = self[dynamicMember: keyPath] else {
            return configuration.fallbackMetric
        }
        return CGFloat(representation)
    }
}

public extension Double {
    var cgFloat: CGFloat {
        CGFloat(self)
    }
}
