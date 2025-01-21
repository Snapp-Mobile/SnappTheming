//
//  ShapeBuilder.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 14.01.25.
//

import SwiftUI

#if swift(>=5.4)
    @resultBuilder
    public enum ShapeBuilder {
        public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
            builder
        }
    }
#else
    @_functionBuilder
    public enum ShapeBuilder {
        public static func buildBlock<S: Shape>(_ builder: S) -> some Shape {
            builder
        }
    }
#endif

extension ShapeBuilder {
    public static func buildOptional<S: Shape>(_ component: S?) -> EitherShape<S, EmptyShape> {
        component.flatMap(EitherShape.first) ?? EitherShape.second(EmptyShape())
    }

    public static func buildEither<First: Shape, Second: Shape>(first component: First) -> EitherShape<First, Second> {
        .first(component)
    }

    public static func buildEither<First: Shape, Second: Shape>(second component: Second) -> EitherShape<First, Second> {
        .second(component)
    }
}
