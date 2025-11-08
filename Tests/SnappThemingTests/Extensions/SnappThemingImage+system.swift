//
//  File.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/8/25.
//

import SnappTheming
import Foundation

extension SnappThemingImage {
    static func system(name: String) -> SnappThemingImage? {
        #if canImport(UIKit)
            SnappThemingImage(systemName: name)
        #elseif canImport(AppKit)
            SnappThemingImage(systemSymbolName: name, accessibilityDescription: "test")
        #endif
    }
}
