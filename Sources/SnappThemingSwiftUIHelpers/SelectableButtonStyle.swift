//
//  SelectableButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 10.01.2025.
//

import SwiftUI

/// A private structure that dynamically renders a view based on the `isSelected` value in the environment.
private struct Selected<Body: View>: View {
    /// The `isSelected` value from the environment, indicating the current state of selection.
    ///
    /// - Note: The `isSelected` environment variable must be set using the `selected(_:)` view modifier.
    @Environment(\.isSelected) var isSelected

    /// A closure that takes the `isSelected` state and returns a view to display.
    var makeBody: (Bool) -> Body

    /// Initializes a `Selected` view.
    ///
    /// - Parameter makeBody: A closure that takes a Boolean value indicating the selection state and returns the corresponding view.
    init(@ViewBuilder makeBody: @escaping (Bool) -> Body) {
        self.makeBody = makeBody
    }

    /// The content and behavior of the view.
    var body: some View {
        makeBody(isSelected)
    }
}

/// An extension on `View` that provides a modifier for applying a selectable button style.
extension View {
    /// Applies a dynamic button style based on the selection state.
    ///
    /// This modifier allows a button to switch between two styles—`normalStyle` and `selectedStyle`—depending on the `isSelected`
    /// environment value. The selection state is controlled using the `selected(_:)` view modifier.
    ///
    /// - Parameters:
    ///   - normalStyle: The button style to apply when the button is not selected.
    ///   - selectedStyle: The button style to apply when the button is selected.
    /// - Returns: A view with the dynamic button style applied.
    ///
    /// - Note: The `selected(_:)` modifier must be used to set the `isSelected` environment variable in the view hierarchy.
    /// This variable determines the selection state of the button.
    public func buttonStyle<NormalStyle, SelectedStyle>(
        _ normalStyle: NormalStyle,
        selected selectedStyle: SelectedStyle
    ) -> some View where NormalStyle: ButtonStyle, SelectedStyle: ButtonStyle {
        Selected { isSelected in
            if isSelected {
                buttonStyle(selectedStyle)
            } else {
                buttonStyle(normalStyle)
            }
        }
    }
}
