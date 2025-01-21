//
//  SnappThemingTypographyRepresentation.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation

/// A representation of typography in the SnappTheming framework.
public struct SnappThemingTypographyRepresentation: Codable {
    /// A token that represents font information.
    public let font: SnappThemingToken<SnappThemingFontInformation>
    /// A token that represents the font size.
    public let fontSize: SnappThemingToken<Double>
}
