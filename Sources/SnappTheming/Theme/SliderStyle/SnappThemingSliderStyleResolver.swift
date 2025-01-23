//
//  SnappThemingSliderStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

/// A resolver that provides the style properties for a slider, including track colors,
/// typography, and tick mark color.
public struct SnappThemingSliderStyleResolver {
    /// The color used for the minimum track of the slider.
    public let minimumTrackTintColor: Color

    /// The secondary color used for the minimum track of the slider.
    public let minimumTrackTintColorSecondary: Color

    /// The color used for the maximum track of the slider.
    public let maximumTrackTintColor: Color

    /// The typography settings for the header text associated with the slider.
    public let headerTypography: SnappThemingTypographyResolver

    /// The typography settings for the tick marks associated with the slider.
    public let tickMarkTypography: SnappThemingTypographyResolver

    /// The color used for the tick marks on the slider.
    public let tickMarkColor: Color
}

extension SnappThemingSliderStyleResolver {
    /// A static method to return a `SnappThemingSliderStyleResolver` with default values.
    ///
    /// - Returns: A `SnappThemingSliderStyleResolver` instance with default colors set to `.clear`
    /// and default typography settings set to `.system` font with a size of `32`.
    public static func empty() -> Self {
        SnappThemingSliderStyleResolver(
            minimumTrackTintColor: .clear,
            minimumTrackTintColorSecondary: .clear,
            maximumTrackTintColor: .clear,
            headerTypography: .init(.system, fontSize: 32),
            tickMarkTypography: .init(.system, fontSize: 32),
            tickMarkColor: .clear
        )
    }
}
