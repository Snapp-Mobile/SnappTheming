//
//  SAThemingButtonStyleShapeConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

public struct SAThemingButtonStyleShapeConfiguration {
    public let fallbackShape: SAThemingButtonStyleType
    let themeConfiguration: SAThemingParserConfiguration
}

public extension SAThemingButtonStyleShapeRepresentation {
    func resolver() -> SAThemingButtonStyleShapeResolver {
        SAThemingButtonStyleShapeResolver(buttonStyleType: buttonStyleShape)
    }
}

