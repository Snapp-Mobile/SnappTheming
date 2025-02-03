//
//  InsettableShapeBuilder.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 14.01.25.
//

import SwiftUI

#if swift(>=5.4)
    /// A result builder that constructs an `InsettableShape` from multiple shape expressions.
    ///
    /// `InsettableShapeBuilder` enables the composition of `InsettableShape` instances
    /// using Swift's result builder syntax, allowing for more declarative and flexible shape construction.
    @resultBuilder
    public enum InsettableShapeBuilder {
        /// Constructs a single `InsettableShape` from a given shape.
        ///
        /// - Parameter builder: The `InsettableShape` to be used in the result.
        /// - Returns: The provided `InsettableShape` instance.
        public static func buildBlock<S: InsettableShape>(_ builder: S) -> some InsettableShape {
            builder
        }
    }
#else
    @_functionBuilder
    public enum InsettableShapeBuilder {
        /// Constructs a single `InsettableShape` from a given shape.
        ///
        /// - Parameter builder: The `InsettableShape` to be used in the result.
        /// - Returns: The provided `InsettableShape` instance.
        public static func buildBlock<S: InsettableShape>(_ builder: S) -> some InsettableShape {
            builder
        }
    }
#endif

extension InsettableShapeBuilder {
    /// Constructs an `EitherInsettableShape` from an optional `InsettableShape`.
    ///
    /// - If `component` is non-nil, it is wrapped in `EitherInsettableShape.first(_:)`.
    /// - If `component` is `nil`, it defaults to `EmptyShape()`, wrapped in `EitherInsettableShape.second(_:)`.
    ///
    /// - Parameter component: The optional `InsettableShape` to construct.
    /// - Returns: An `EitherInsettableShape` containing either the provided shape or `EmptyShape`.
    public static func buildOptional<S: InsettableShape>(_ component: S?) -> EitherInsettableShape<S, EmptyShape> {
        component.flatMap(EitherInsettableShape.first) ?? .second(EmptyShape())
    }

    /// Constructs an `EitherInsettableShape` using the first branch of a conditional statement.
    ///
    /// This method is used when a shape is chosen in a Swift result builder `if-else` or `switch` construct.
    ///
    /// - Parameter component: The `InsettableShape` used when the first branch is selected.
    /// - Returns: An `EitherInsettableShape` wrapping the provided shape in the `.first` case.
    public static func buildEither<First: InsettableShape, Second: InsettableShape>(
        first component: First
    ) -> EitherInsettableShape<First, Second> {
        .first(component)
    }

    /// Constructs an `EitherInsettableShape` using the second branch of a conditional statement.
    ///
    /// This method is used when a shape is chosen in a Swift result builder `if-else` or `switch` construct.
    ///
    /// - Parameter component: The `InsettableShape` used when the second branch is selected.
    /// - Returns: An `EitherInsettableShape` wrapping the provided shape in the `.second` case.
    public static func buildEither<First: InsettableShape, Second: InsettableShape>(
        second component: Second
    ) -> EitherInsettableShape<First, Second> {
        .second(component)
    }
}
