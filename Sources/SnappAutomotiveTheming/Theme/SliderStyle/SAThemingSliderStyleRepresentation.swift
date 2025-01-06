//
//  SAThemingSliderStyleRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SAThemingSliderStyleRepresentation: Codable {
    public let minimumTrackTintColor: SAThemingToken<SAThemingColorRepresentation>
    public let minimumTrackTintColorSecondary: SAThemingToken<SAThemingColorRepresentation>
    public let maximumTrackTintColor: SAThemingToken<SAThemingColorRepresentation>
    public let headerTypography: SAThemingToken<SAThemingTypographyRepresentation>
    public let tickMarkTypography: SAThemingToken<SAThemingTypographyRepresentation>
    public let tickMarkColor: SAThemingToken<SAThemingColorRepresentation>
}
