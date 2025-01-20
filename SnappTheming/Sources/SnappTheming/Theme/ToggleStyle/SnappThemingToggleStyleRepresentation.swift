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

    /// Initializes a new instance of `SnappThemingToggleStyleRepresentation`.
    /// - Parameters:
    ///   - tintColor: The active tint color of the toggle.
    ///   - disabledTintColor: The tint color of the toggle when it is disabled.
    public init(
        tintColor: SnappThemingToken<SnappThemingColorRepresentation>,
        disabledTintColor: SnappThemingToken<SnappThemingColorRepresentation>
    ) {
        self.tintColor = tintColor
        self.disabledTintColor = disabledTintColor
    }
}
