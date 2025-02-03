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

    /// Returns a shape style based on the given theming configuration.
    ///
    /// This method applies a style to a shape using the provided `SnappThemingGradientConfiguration`.
    /// The returned style could be a `LinearGradient`, `RadialGradient`, `Color`, or another
    /// `ShapeStyle`, depending on the configuration.
    ///
    /// - Parameter configuration: The gradient configuration defining the appearance of the shape style.
    /// - Returns: A `ShapeStyle` object that can be applied to a shape.
    func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> S
}

struct SnappThemingClearShapeStyleConfiguration: SnappThemingGradientProviding {
    func shapeStyleUsing(_ configuration: SnappThemingGradientConfiguration) -> Color {
        Color.clear
    }
}
