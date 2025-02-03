//
//  SnappThemingFontManager.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation

/// A protocol that defines the necessary methods for managing fonts in the theming system.
///
/// `SnappThemingFontManager` is responsible for registering and unregistering fonts in the
/// theming system, allowing for dynamic font management, and providing flexibility
/// when working with fonts in your app.
public protocol SnappThemingFontManager {
    /// Registers an array of fonts with the theming system.
    ///
    /// This method allows multiple fonts to be added to the theming system at once.
    ///
    /// - Parameter fonts: An array of `SnappThemingFontInformation` objects that describe the fonts to be registered.
    func registerFonts(_ fonts: [SnappThemingFontInformation])

    /// Unregisters an array of fonts from the theming system.
    ///
    /// This method removes the specified fonts from the theming system, so they will no longer be available.
    ///
    /// - Parameter fonts: An array of `SnappThemingFontInformation` objects that describe the fonts to be unregistered.
    func unregisterFonts(_ fonts: [SnappThemingFontInformation])

    /// Registers a single font with the theming system.
    ///
    /// This method allows a single font to be added to the theming system.
    ///
    /// - Parameter font: A `SnappThemingFontInformation` object that describes the font to be registered.
    func registerFont(_ font: SnappThemingFontInformation)
}
