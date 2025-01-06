//
//  SAThemingSliderStyleConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation
import SwiftUI

public struct SAThemingSliderStyleConfiguration {
    public let fallbackMinimumTrackTintColor: Color
    public let fallbackMaximumTrackTintColor: Color
    public let fallbackFontSize: CGFloat
    public let fallbackTickMarkColor: Color

    let typographies: SAThemingTypographyDeclarations
    let colors: SAThemingColorDeclarations
    let fonts: SAThemingFontDeclarations
    let metrics: SAThemingMetricDeclarations
    let colorFormat: SAThemingColorFormat
}
