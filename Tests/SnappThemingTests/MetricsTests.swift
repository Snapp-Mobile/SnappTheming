//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import Testing
import UIKit

@testable import SnappTheming

@Suite
struct MetricsTests {
    @Test
    func parseMetrics() throws {
        let json =
            """
            {
                "metrics": {
                    "small": 4,
                    "medium": 8.5,
                    "large": 12.0 
                }
            }
            """

        let declaration = try SnappThemingParser.parse(from: json)
        let smallDouble: Double = declaration.metrics.small
        let mediumCGFloat: CGFloat = declaration.metrics.medium
        #expect(smallDouble == 4.0)
        #expect(mediumCGFloat == 8.5)
        #expect(declaration.metrics.large == 12.0)
    }

    @Test
    func useFallbackMetricIfMissing() throws {
        let declaration = try SnappThemingParser.parse(from: "{}")
        let small: CGFloat = declaration.metrics.small
        #expect(small == SnappThemingParserConfiguration.default.fallbackMetric)
    }

    // This is a temporary test to prevent code coverage to go down.
    // Will be removed later after some adjustments to `SnappThemingDeclarations` resolution mechanism.
    @Test
    func convertDoubleToCGFloat() throws {
        let double: Double = 12.4
        let cgFloat = double.cgFloat

        #expect(cgFloat == 12.4)
    }
}
