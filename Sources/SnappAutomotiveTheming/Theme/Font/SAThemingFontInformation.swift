//
//  SAThemingFontInformation.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation

public struct SAThemingFontInformation: Codable {
    public let postScriptName: String
    public let source: SAThemingDataURI
}

public extension SAThemingFontInformation {
    var resolver: SAThemingFontResolver {
        SAThemingFontResolver(fontName: postScriptName)
    }
}
