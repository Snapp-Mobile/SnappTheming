//
//  GradientConfiguration.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import Foundation
import SwiftUI

public protocol SAThemingShapeStyleProviding: Codable {
    associatedtype SomeShape: ShapeStyle
    var shapeStyle: SomeShape { get }
}

struct SAThemingClearShapeStyleConfiguration: SAThemingShapeStyleProviding {
    var shapeStyle: Color {
        Color.clear
    }
}
