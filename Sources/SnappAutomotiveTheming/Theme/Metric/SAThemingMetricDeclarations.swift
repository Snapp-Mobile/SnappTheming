//
//  SAThemingMetricDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation

public typealias SAThemingMetricDeclarations = SAThemingDeclarations<Double, SAThemingMetricConfiguration>

public struct SAThemingMetricConfiguration {
    public let fallbackMetric: CGFloat
}

extension SAThemingDeclarations where DeclaredValue == Double, Configuration == SAThemingMetricConfiguration {
    public init(cache: [String: SAThemingToken<Double>]?, configuration: SAThemingParserConfiguration = .default) {
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
