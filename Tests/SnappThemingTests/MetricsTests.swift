//
//  MetricsTests.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

@testable import SnappTheming
import Testing
import UIKit

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
        #expect(declaration.metrics.small == 4.0)
        #expect(declaration.metrics.medium == 8.5)
        #expect(declaration.metrics.large == 12.0)
    }
}
