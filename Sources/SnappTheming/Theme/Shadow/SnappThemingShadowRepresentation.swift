//
//  SnappThemingShadowRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/10/25.
//

import Foundation

/// Representation of a shadow configuration using theming tokens.
///
/// This struct defines a shadow using theming tokens that reference other design tokens
/// for colors and metrics, allowing for consistent and themeable shadow definitions.
public struct SnappThemingShadowRepresentation: Codable {
   /// Color defines the color of the shadow as a solid, reduced opacity, or modified color value.
   ///
   /// This token references a color representation that will be resolved through the
   /// color theming system to produce the final shadow color.
   public let color: SnappThemingToken<SnappThemingColorRepresentation>

   /// Blur(radius) defines the the softness of the shadow edges.
   ///
   /// Defines the softness of edges (higher = softer, more diffused). This token
   /// references a metric value that determines how blurred the shadow appears.
   public let radius: SnappThemingToken<Double>

   /// X defines the horizontal position of the shadow.
   ///
   /// This token references a metric value that determines the horizontal offset
   /// of the shadow relative to the element casting it.
   public let x: SnappThemingToken<Double>

   /// Y defines the vertical position of the shadow.
   ///
   /// This token references a metric value that determines the vertical offset
   /// of the shadow relative to the element casting it.
   public let y: SnappThemingToken<Double>

   /// Spread(radius) defines the size of the shadow.
   ///
   /// Defines how much the shadow grows or shrinks. This token references a metric
   /// value that controls the shadow's expansion beyond the original element size.
   public let spread: SnappThemingToken<Double>
}
