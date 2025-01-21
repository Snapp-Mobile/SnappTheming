//
//  EitherInsettableShape.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import SwiftUI

public enum EitherInsettableShape<First: InsettableShape, Second: InsettableShape>: InsettableShape {
    case first(First)
    case second(Second)
    
    public func path(in rect: CGRect) -> Path {
        switch self {
        case let .first(first):
            return first.path(in: rect)
        case let .second(second):
            return second.path(in: rect)
        }
    }
    
    public func inset(by amount: CGFloat) -> EitherInsettableShape<First.InsetShape, Second.InsetShape> {
        switch self {
        case let .first(first):
            return .first(first.inset(by: amount))
        case let .second(second):
            return .second(second.inset(by: amount))
        }
    }
}
