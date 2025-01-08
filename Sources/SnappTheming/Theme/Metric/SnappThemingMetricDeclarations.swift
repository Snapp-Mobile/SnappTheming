//
//  SnappThemingMetricDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation

/// Handles numeric tokens, such as spacing, corner radius, border widths. Useful for creating a consistent design language with reusable measurements.
public typealias SnappThemingMetricDeclarations = SnappThemingDeclarations<Double, SnappThemingMetricConfiguration>

public struct SnappThemingMetricConfiguration {
    public let fallbackMetric: CGFloat
}

extension SnappThemingDeclarations where DeclaredValue == Double, Configuration == SnappThemingMetricConfiguration {
    public init(cache: [String: SnappThemingToken<Double>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .metrics,
            configuration: .init(
                fallbackMetric: configuration.fallbackMetric
            )
        )
    }

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
