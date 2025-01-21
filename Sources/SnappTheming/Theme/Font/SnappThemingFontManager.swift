//
//  SnappThemingFontManager.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation

public protocol SnappThemingFontManager {
    func registerFonts(_ fonts: [SnappThemingFontInformation])
    func unregisterFonts(_ fonts: [SnappThemingFontInformation])
    func registerFont(_ font: SnappThemingFontInformation)
}
