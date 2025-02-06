//
//  ShapeBuilder.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 14.01.25.
//

import SwiftUI

#if swift(>=5.4)
    /// A result builder that constructs a `Shape` from multiple shape expressions.
    ///
    /// `ShapeBuilder` enables the composition of `Shape` instances using Swift’s result builder syntax,
    /// allowing for a flexible, declarative way to combine shapes.
    @resultBuilder
    public enum ShapeBuilder {
        /// Constructs a single `Shape` from a given shape expression.
        ///
        /// - Parameter builder: The `Shape` to be used in the result.
        /// - Returns: The provided `Shape` instance.
        public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
            builder
        }
    }
#else
    @_functionBuilder
    public enum ShapeBuilder {
        /// Constructs a single `Shape` from a given shape expression.
        ///
        /// - Parameter builder: The `Shape` to be used in the result.
        /// - Returns: The provided `Shape` instance.
        public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
            builder
        }
    }
#endif

extension ShapeBuilder {
    /// Constructs an `EitherShape` from an optional `Shape`.
    ///
    /// - If `component` is non-nil, it is wrapped in `EitherShape.first(_:)`.
    /// - If `component` is `nil`, it defaults to `EmptyShape()`, wrapped in `EitherShape.second(_:)`.
    ///
    /// - Parameter component: The optional `Shape` to construct.
    /// - Returns: An `EitherShape` containing either the provided shape or `EmptyShape`.
    public static func buildOptional<S: Shape>(_ component: S?) -> EitherShape<S, EmptyShape> {
        component.flatMap(EitherShape.first) ?? EitherShape.second(EmptyShape())
    }

    /// Constructs an `EitherShape` using the first branch of a conditional statement.
    ///
    /// This method is used when a shape is chosen in a Swift result builder `if-else` or `switch` construct.
    ///
    /// - Parameter component: The `Shape` used when the first branch is selected.
    /// - Returns: An `EitherShape` wrapping the provided shape in the `.first` case.
    public static func buildEither<First: Shape, Second: Shape>(first component: First) -> EitherShape<First, Second> {
        .first(component)
    }

    /// Constructs an `EitherShape` using the second branch of a conditional statement.
    ///
    /// This method is used when a shape is chosen in a Swift result builder `if-else` or `switch` construct.
    ///
    /// - Parameter component: The `Shape` used when the second branch is selected.
    /// - Returns: An `EitherShape` wrapping the provided shape in the `.second` case.
    public static func buildEither<First: Shape, Second: Shape>(second component: Second) -> EitherShape<First, Second> {
        .second(component)
    }
}
