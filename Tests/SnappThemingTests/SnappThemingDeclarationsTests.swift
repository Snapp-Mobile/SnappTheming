//
//  SnappThemingDeclarationsTests.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.01.2025.
//

import Testing

@testable import SnappTheming

@Suite
struct SnappThemingDeclarationsTests {
    @Test
    func returnNilIfKeyIsEmpty() throws {
        let declarations = SnappThemingDeclarations<Double, Void>(cache: nil, rootKey: .metrics)
        let value: Double? = declarations[dynamicMember: ""]
        #expect(value == nil)
    }
}
