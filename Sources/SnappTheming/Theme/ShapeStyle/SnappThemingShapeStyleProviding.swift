//
//  SnappThemingShapeStyleProviding.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import Foundation
import SwiftUI

public protocol SnappThemingShapeStyleProviding: Codable {
    associatedtype SomeShape: ShapeStyle
    var shapeStyle: SomeShape { get }
}

struct SnappThemingClearShapeStyleConfiguration: SnappThemingShapeStyleProviding {
    var shapeStyle: Color {
        Color.clear
    }
}
