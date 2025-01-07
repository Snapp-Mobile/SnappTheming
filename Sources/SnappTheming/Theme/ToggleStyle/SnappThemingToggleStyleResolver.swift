//
//  SnappThemingToggleStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import SwiftUI

public struct SnappThemingToggleStyleResolver {
    public let tintColor: Color
    public let disabledTintColor: Color
}

public extension SnappThemingToggleStyleResolver {
    static func empty() -> Self {
        SnappThemingToggleStyleResolver(
            tintColor: .clear,
            disabledTintColor: .clear
        )
    }
}
