//
//  SAThemingToggleStyleRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SAThemingToggleStyleRepresentation: Codable {
    public let tintColor: SAThemingToken<SAThemingColorRepresentation>
    public let disabledTintColor: SAThemingToken<SAThemingColorRepresentation>
}
