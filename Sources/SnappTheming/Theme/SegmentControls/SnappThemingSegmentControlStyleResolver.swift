//
//  SnappThemingSegmentControlStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SnappThemingSegmentControlStyleResolver {
    public let selectedButtonStyle: SnappThemingButtonStyleResolver
    public let normalButtonStyle: SnappThemingButtonStyleResolver
    public let surfaceColor: SnappThemingInteractiveColor
    public let borderColor: SnappThemingInteractiveColor
    public let borderWidth: Double
    public let innerPadding: Double
    public let shape: SnappThemingButtonStyleType
}
