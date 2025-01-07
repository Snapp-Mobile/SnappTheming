//
//  SnappThemingButtonStyleShapeConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

public struct SnappThemingButtonStyleShapeConfiguration {
    public let fallbackShape: SnappThemingButtonStyleType
    let themeConfiguration: SnappThemingParserConfiguration
}

public extension SnappThemingButtonStyleShapeRepresentation {
    func resolver() -> SnappThemingButtonStyleShapeResolver {
        SnappThemingButtonStyleShapeResolver(buttonStyleType: buttonStyleShape)
    }
}

