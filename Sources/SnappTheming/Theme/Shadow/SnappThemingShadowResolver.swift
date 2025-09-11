//
//  SnappThemingShadowResolver.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import SwiftUI

/// A resolver that contains fully resolved shadow properties for UI rendering.
///
/// This struct represents a shadow with all properties resolved to concrete values,
/// ready to be applied to SwiftUI views or other UI components.
///
/// ### Usage
/// ```swift
///
/// @Environment(Theme.self) private var theme
///
/// // Apply to a SwiftUI view
/// Text("Hello")
///     .shadow(
///         color: theme.shadows.action.color,
///         radius: theme.shadows.action.radius,
///         x: theme.shadows.action.x,
///         y: theme.shadows.action.y
///     )
/// ```
public struct SnappThemingShadowResolver: Sendable {
   /// The resolved color for the shadow.
   public let color: Color

   /// The resolved blur radius for the shadow.
   public let radius: Double

   /// The resolved horizontal offset for the shadow.
   public let x: Double

   /// The resolved vertical offset for the shadow.
   public let y: Double

   /// The resolved spread radius for the shadow.
   public let spread: Double

   /// Creates a new shadow resolver with the specified properties.
   ///
   /// - Parameter color: The color of the shadow.
   /// - Parameter radius: The blur radius of the shadow.
   /// - Parameter x: The horizontal offset of the shadow.
   /// - Parameter y: The vertical offset of the shadow.
   /// - Parameter spread: The spread radius of the shadow.
   public init(
       color: Color,
       radius: Double,
       x: Double,
       y: Double,
       spread: Double
   ) {
       self.color = color
       self.radius = radius
       self.x = x
       self.y = y
       self.spread = spread
   }

   /// A fallback shadow resolver used for debugging purposes.
   ///
   /// This shadow uses distinctive values (pink color and negative radius) to make it
   /// easily identifiable when fallback values are being used in the theming system.
   public static var fallback: Self {
       SnappThemingShadowResolver(
           color: .pink,
           radius: -11,
           x: 1,
           y: 3,
           spread: 0.25
       )
   }
}
