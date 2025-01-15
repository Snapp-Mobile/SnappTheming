//
//  ThemeDeclaration+Preview.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.12.2024.
//

import SnappTheming

extension SnappThemingDeclaration {
    public static let preview: SnappThemingDeclaration = try! SnappThemingParser.parse(from: sampleJSON)
}
