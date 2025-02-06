//
//  EmptyShape.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 14.01.25.
//

import SwiftUI

/// A shape that renders as an empty path.
///
/// `EmptyShape` conforms to `InsettableShape` but does not draw any visible content.
/// It can be useful in cases where a shape is required but no actual rendering is needed,
/// such as conditional shape rendering or placeholder geometry.
public struct EmptyShape: InsettableShape {
    /// Creates an empty shape.
    public init() {}

    /// Returns an empty path, effectively making this shape invisible.
    ///
    /// - Parameter rect: The bounding rectangle within which the path should be drawn.
    /// - Returns: An empty `Path` instance.
    public func path(in rect: CGRect) -> Path {
        Path()
    }

    /// Returns an inset version of the empty shape.
    ///
    /// Since `EmptyShape` does not render any content, insetting it has no visible effect.
    ///
    /// - Parameter amount: The amount by which to inset the shape.
    /// - Returns: The same `EmptyShape` instance.
    public func inset(by amount: CGFloat) -> some InsettableShape {
        self
    }
}
