//
//  SnappThemingFontInformation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation

/// Represents information about a theming font, including its PostScript name and source data.
public struct SnappThemingFontInformation: Codable, Hashable {
    /// The PostScript name of the font, used to identify the font in the system.
    public let postScriptName: String

    /// The data source for the font, typically encoded as a data URI.
    public let source: SnappThemingDataURI
}

public extension SnappThemingFontInformation {
    /// A resolver for the font, providing access to the font resource using its PostScript name.
    var resolver: SnappThemingFontResolver {
        SnappThemingFontResolver(fontName: postScriptName)
    }
}
