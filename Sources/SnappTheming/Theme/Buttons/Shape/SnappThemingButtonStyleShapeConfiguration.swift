//
//  SnappThemingButtonStyleShapeConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI
/// A configuration structure for button style shapes in the SnappTheming framework.
///
/// This struct defines the fallback shape for a button style, providing a default
/// shape configuration in case a specific shape is not available.
public struct SnappThemingButtonStyleShapeConfiguration {
    /// The fallback button shape type to use when no specific shape is defined.
    public let fallbackShape: SnappThemingButtonStyleType

    /// The configuration used for parsing and applying theming.
    let themeConfiguration: SnappThemingParserConfiguration
}

public extension SnappThemingButtonStyleShapeRepresentation {
    /// Resolves the button style shape and returns a resolver object for further theming logic.
    ///
    /// - Returns: A `SnappThemingButtonStyleShapeResolver` instance that resolves the button's shape style.
    func resolver() -> SnappThemingButtonStyleShapeResolver {
        SnappThemingButtonStyleShapeResolver(buttonStyleType: buttonStyleShape)
    }
}
