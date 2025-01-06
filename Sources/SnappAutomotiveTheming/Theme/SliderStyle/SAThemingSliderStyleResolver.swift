//
//  SAThemingSliderStyleResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

public struct SAThemingSliderStyleResolver {
    public let minimumTrackTintColor: Color
    public let minimumTrackTintColorSecondary: Color
    public let maximumTrackTintColor: Color
    public let headerTypography: SAThemingTypographyResolver
    public let tickMarkTypography: SAThemingTypographyResolver
    public let tickMarkColor: Color
}

public extension SAThemingSliderStyleResolver {
    static func empty() -> Self {
        SAThemingSliderStyleResolver(
            minimumTrackTintColor: .clear,
            minimumTrackTintColorSecondary: .clear,
            maximumTrackTintColor: .clear,
            headerTypography: .init(.system, fontSize: 32),
            tickMarkTypography:  .init(.system, fontSize: 32),
            tickMarkColor: .clear
        )
    }
}
