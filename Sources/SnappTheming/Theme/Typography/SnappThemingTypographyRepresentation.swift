//
//  SnappThemingTypographyRepresentation.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation

public struct SnappThemingTypographyRepresentation: Codable {
    public let font: SnappThemingToken<SnappThemingFontInformation>
    public let fontSize: SnappThemingToken<Double>
}
