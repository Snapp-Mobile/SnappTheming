//
//  SnappThemingShadowModifier.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 9/11/25.
//

import SnappTheming
import SwiftUI

/// A SwiftUI view modifier that applies shadow effects using resolved shadow configuration.
///
/// This modifier provides a convenient way to apply shadows to SwiftUI views using
/// the theming system's shadow resolver.
public struct SnappThemingShadowModifier: ViewModifier {
    /// The resolved shadow configuration containing all shadow properties.
    var shadowConfiguration: SnappThemingShadowResolver

    /// Applies the shadow configuration to the provided content view.
    ///
    /// - Parameter content: The view to which the shadow will be applied.
    /// - Returns: The content view with the shadow effect applied.
    ///
    /// - Note: The spread property from the shadow configuration is not applied as SwiftUI's shadow modifier doesn't support spread radius. If you need spread functionality, consider creating a custom shadow implementation or using alternative approaches such as background views with scaling transforms.
    public func body(content: Content) -> some View {
        content
            .shadow(
                color: shadowConfiguration.color,
                radius: shadowConfiguration.radius,
                x: shadowConfiguration.x,
                y: shadowConfiguration.y
            )
    }
}

/// Extends `View` to include a modifier for applying themed shadow effects.
extension View {
    /// Applies a shadow effect to the view using a resolved shadow configuration.
    ///
    /// This convenience method allows you to apply themed shadows directly to any SwiftUI view
    /// using the shadow resolver from the theming system.
    ///
    /// - Parameter configuration: The resolved shadow configuration to apply.
    /// - Returns: The view with the shadow effect applied.
    ///
    /// Example usage:
    /// ```swift
    /// struct CardView: View {
    ///     var body: some View {
    ///         VStack {
    ///             Text("Card Content")
    ///                 .padding()
    ///         }
    ///         .background(Color.white)
    ///         .cornerRadius(12)
    ///         .shadow(shadowDeclarations.card.elevated) // Apply themed shadow
    ///     }
    /// }
    ///
    /// struct ButtonView: View {
    ///     var body: some View {
    ///         Button("Tap Me") {
    ///             // Action
    ///         }
    ///         .padding()
    ///         .background(Color.blue)
    ///         .foregroundColor(.white)
    ///         .cornerRadius(8)
    ///         .shadow(shadowDeclarations.button.primary) // Apply themed shadow
    ///     }
    /// }
    /// ```
    public func shadow(_ configuration: SnappThemingShadowResolver) -> some View {
        modifier(SnappThemingShadowModifier(shadowConfiguration: configuration))
    }
}
