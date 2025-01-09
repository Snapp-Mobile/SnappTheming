//
//  SnappThemingSliderStyleConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation
import SwiftUI

/// A configuration structure that holds fallback values and related declarations for slider style elements such as track colors, font size, and tick mark color.
public struct SnappThemingSliderStyleConfiguration {
    /// The fallback color for the minimum track of the slider.
    public let fallbackMinimumTrackTintColor: Color

    /// The fallback color for the maximum track of the slider.
    public let fallbackMaximumTrackTintColor: Color

    /// The fallback font size for the slider's header and tick marks.
    public let fallbackFontSize: CGFloat

    /// The fallback color for the tick marks on the slider.
    public let fallbackTickMarkColor: Color

    let typographies: SnappThemingTypographyDeclarations
    let colors: SnappThemingColorDeclarations
    let fonts: SnappThemingFontDeclarations
    let metrics: SnappThemingMetricDeclarations
    let colorFormat: SnappThemingColorFormat
}
