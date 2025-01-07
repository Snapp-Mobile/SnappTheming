//
//  SnappThemingFontInformation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation

public struct SnappThemingFontInformation: Codable {
    public let postScriptName: String
    public let source: SnappThemingDataURI
}

public extension SnappThemingFontInformation {
    var resolver: SnappThemingFontResolver {
        SnappThemingFontResolver(fontName: postScriptName)
    }
}
