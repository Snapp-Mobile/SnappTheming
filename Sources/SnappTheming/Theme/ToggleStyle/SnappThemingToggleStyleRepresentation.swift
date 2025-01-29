//
//  SnappThemingToggleStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// A representation of toggle style in the SnappTheming framework.
///
/// This struct defines the visual appearance of a toggle, including its tint color and
/// the color used when the toggle is disabled. Each color is represented by a
/// `SnappThemingToken` linked to a `SnappThemingColorRepresentation`.
public struct SnappThemingToggleStyleRepresentation: Codable {
    /// The tint color of the toggle when it is in its active state.
    public let tintColor: SnappThemingToken<SnappThemingColorRepresentation>

    /// The tint color of the toggle when it is in its disabled state.
    public let disabledTintColor: SnappThemingToken<SnappThemingColorRepresentation>
}
