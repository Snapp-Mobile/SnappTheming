//
//  EmptyShape.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 14.01.25.
//

import SwiftUI

public struct EmptyShape: InsettableShape {
    public init() {}

    public func path(in rect: CGRect) -> Path {
        Path()
    }

    public func inset(by amount: CGFloat) -> some InsettableShape {
        self
    }
}
