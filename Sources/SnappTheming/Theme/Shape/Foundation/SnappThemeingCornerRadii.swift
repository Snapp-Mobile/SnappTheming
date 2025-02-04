//
//  SnappThemeingCornerRadii.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 04.02.2025.
//

import Foundation

public struct SnappThemeingCornerRadii: Codable, Sendable, Equatable {
    public let topLeading: CGFloat
    public let bottomLeading: CGFloat
    public let bottomTrailing: CGFloat
    public let topTrailing: CGFloat
}
