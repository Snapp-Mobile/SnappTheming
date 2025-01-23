//
//  SnappThemingShapeStyleProviding.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import Foundation
import SwiftUI

/// A protocol that defines a shape style configuration for theming purposes.
public protocol SnappThemingGradientProviding: Codable {
    /// The associated type that represents the shape style to be applied.

    ///
    /// This associated type defines the concrete type of the shape style that conforms to the `ShapeStyle`
    /// protocol.
    /// It allows different shape style configurations to be defined in a flexible way. For example,
    /// the associated type could be a `LinearGradient`, `RadialGradient`, or `Color`, or any other
    /// custom shape style.
    associatedtype S: ShapeStyle

    /// The shape style to be applied to the shape.
    ///
    /// - Returns: The shape style that is applied to the shape (e.g., a `LinearGradient`, `RadialGradient`, `Color`, etc.).
    var shapeStyle: S { get }
}

struct SnappThemingClearShapeStyleConfiguration: SnappThemingGradientProviding {
    var shapeStyle: some ShapeStyle {
        Color.clear
    }
}
