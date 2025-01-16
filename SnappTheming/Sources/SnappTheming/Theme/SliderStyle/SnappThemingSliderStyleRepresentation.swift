//
//  SnappThemingSliderStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// A representation of slider style in the SnappTheming framework.
public struct SnappThemingSliderStyleRepresentation: Codable {
    public let minimumTrackTintColor: SnappThemingToken<SnappThemingColorRepresentation>
    public let minimumTrackTintColorSecondary: SnappThemingToken<SnappThemingColorRepresentation>
    public let maximumTrackTintColor: SnappThemingToken<SnappThemingColorRepresentation>
    public let headerTypography: SnappThemingToken<SnappThemingTypographyRepresentation>
    public let tickMarkTypography: SnappThemingToken<SnappThemingTypographyRepresentation>
    public let tickMarkColor: SnappThemingToken<SnappThemingColorRepresentation>
}
