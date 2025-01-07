//
//  SnappThemingToggleStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SnappThemingToggleStyleRepresentation: Codable {
    public let tintColor: SnappThemingToken<SnappThemingColorRepresentation>
    public let disabledTintColor: SnappThemingToken<SnappThemingColorRepresentation>
}
