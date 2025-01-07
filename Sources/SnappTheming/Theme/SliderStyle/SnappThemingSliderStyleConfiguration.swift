//
//  SnappThemingSliderStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation
import SwiftUI

public struct SnappThemingSliderStyleConfiguration {
    public let fallbackMinimumTrackTintColor: Color
    public let fallbackMaximumTrackTintColor: Color
    public let fallbackFontSize: CGFloat
    public let fallbackTickMarkColor: Color

    let typographies: SnappThemingTypographyDeclarations
    let colors: SnappThemingColorDeclarations
    let fonts: SnappThemingFontDeclarations
    let metrics: SnappThemingMetricDeclarations
    let colorFormat: SnappThemingColorFormat
}
