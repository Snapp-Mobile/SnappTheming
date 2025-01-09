//
//  SnappThemingButtonStyleShapeResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation
import SwiftUI

/// A resolver for determining the button style shape in SnappTheming.
///
/// This struct holds the button style type used for theming and provides a way to resolve the shape type.
public struct SnappThemingButtonStyleShapeResolver: Sendable {
    /// The button style type, such as circle, rectangle, or capsule.
    public let buttonStyleType: SnappThemingButtonStyleType

    // MARK: - Initialization

    /// Initializes a new `SnappThemingButtonStyleShapeResolver` with the specified button style type.
    ///
    /// - Parameter buttonStyleType: The button style type to resolve (e.g., circle, rectangle).
    public init(buttonStyleType: SnappThemingButtonStyleType) {
        self.buttonStyleType = buttonStyleType
    }
}
