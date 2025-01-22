//
//  SnappThemingFontDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 22.11.2024.
//

import CoreText
import SwiftUI
import UIKit

public typealias SnappThemingFontDeclarations = SnappThemingDeclarations<SnappThemingFontInformation, Void>

extension SnappThemingDeclarations
where
    DeclaredValue == SnappThemingFontInformation,
    Configuration == Void
{
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        configuration: SnappThemingParserConfiguration = .default
    ) {
        self.init(cache: cache, rootKey: .fonts)
    }

    public subscript(dynamicMember keyPath: String) -> SnappThemingFontResolver {
        guard let representation: DeclaredValue = self[dynamicMember: keyPath] else {
            return .system
        }
        return representation.resolver
    }
}
