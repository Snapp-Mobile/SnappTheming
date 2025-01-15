//
//  SnappThemingSegmentControlStyleResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// A resolver structure that holds resolved values for the segment control style such as button styles, colors, border width, and shape.
public struct SnappThemingSegmentControlStyleResolver {
    /// The resolved style for the selected button in the segment control.
    public let selectedButtonStyle: SnappThemingButtonStyleResolver

    /// The resolved style for the normal (unselected) button in the segment control.
    public let normalButtonStyle: SnappThemingButtonStyleResolver

    /// The resolved interactive color for the surface of the segment control.
    public let surfaceColor: SnappThemingInteractiveColor

    /// The resolved interactive color for the border of the segment control.
    public let borderColor: SnappThemingInteractiveColor

    /// The resolved width of the border for the segment control.
    public let borderWidth: Double

    /// The resolved padding value for the inner content of the segment control.
    public let innerPadding: Double

    /// The resolved shape type for the segment control buttons.
    public let shape: SnappThemingButtonStyleType
}
