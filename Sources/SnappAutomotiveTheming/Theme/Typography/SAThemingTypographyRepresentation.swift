//
//  SAThemingTypographyRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation

public struct SAThemingTypographyRepresentation: Codable {
    public let font: SAThemingToken<SAThemingFontInformation>
    public let fontSize: SAThemingToken<Double>
}
