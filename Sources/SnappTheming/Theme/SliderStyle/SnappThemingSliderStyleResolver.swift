//
//  SnappThemingSliderStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

public struct SnappThemingSliderStyleResolver {
    public let minimumTrackTintColor: Color
    public let minimumTrackTintColorSecondary: Color
    public let maximumTrackTintColor: Color
    public let headerTypography: SnappThemingTypographyResolver
    public let tickMarkTypography: SnappThemingTypographyResolver
    public let tickMarkColor: Color
}

public extension SnappThemingSliderStyleResolver {
    static func empty() -> Self {
        SnappThemingSliderStyleResolver(
            minimumTrackTintColor: .clear,
            minimumTrackTintColorSecondary: .clear,
            maximumTrackTintColor: .clear,
            headerTypography: .init(.system, fontSize: 32),
            tickMarkTypography:  .init(.system, fontSize: 32),
            tickMarkColor: .clear
        )
    }
}
