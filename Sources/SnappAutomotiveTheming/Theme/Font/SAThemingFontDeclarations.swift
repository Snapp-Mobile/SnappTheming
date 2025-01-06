//
//  SAThemingFontDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 22.11.2024.
//

import UIKit
import SwiftUI
import CoreText

public typealias SAThemingFontDeclarations = SAThemingDeclarations<SAThemingFontInformation, Void>

extension SAThemingDeclarations where DeclaredValue == SAThemingFontInformation, Configuration == Void {
    public init(cache: [String: SAThemingToken<SAThemingFontInformation>]?, configuration: SAThemingParserConfiguration = .default) {
        self.init(cache: cache, rootKey: .fonts)
    }

    public subscript(dynamicMember keyPath: String) -> SAThemingFontResolver {
        guard let representation: SAThemingFontInformation = self[dynamicMember: keyPath] else {
            return .system
        }
        return representation.resolver
    }
}
