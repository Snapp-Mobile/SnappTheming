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
}
