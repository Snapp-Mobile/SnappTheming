//
//  SnappThemingToggleStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

/// A representation of toggle style in the SnappTheming framework.
public struct SnappThemingToggleStyleRepresentation: Codable {
    public let tintColor: SnappThemingToken<SnappThemingColorRepresentation>
    public let disabledTintColor: SnappThemingToken<SnappThemingColorRepresentation>
}
