//
//  SnappThemingFontDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 22.11.2024.
//

#if canImport(UIKit)
import UIKit
#endif
import SwiftUI
import CoreText

/// Manages font tokens, such as font families and sizes. Enables consistent typography across the app by centralizing font definitions.
public typealias SnappThemingFontDeclarations = SnappThemingDeclarations<SnappThemingFontInformation, Void>

extension SnappThemingDeclarations where DeclaredValue == SnappThemingFontInformation, Configuration == Void {
    public init(cache: [String: SnappThemingToken<SnappThemingFontInformation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(cache: cache, rootKey: .fonts)
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingFontResolver {
        guard let representation: SnappThemingFontInformation = self[dynamicMember: keyPath] else {
            return .system
        }
        return representation.resolver
    }
}
