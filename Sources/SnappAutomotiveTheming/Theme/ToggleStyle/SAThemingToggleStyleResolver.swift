//
//  SAThemingToggleStyleResolver.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

public struct SAThemingToggleStyleResolver {
    public let tintColor: Color
    public let disabledTintColor: Color
}

public extension SAThemingToggleStyleResolver {
    static func empty() -> Self {
        SAThemingToggleStyleResolver(
            tintColor: .clear,
            disabledTintColor: .clear
        )
    }
}
