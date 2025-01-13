//
//  SelectableButtonStyle.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 10.01.2025.
//

import SwiftUI

/// A custom button style that switches between two styles based on an `isSelected` environment value.
/// - This struct enables creating buttons that change their appearance when selected.
private struct SelectableButtonStyle<NormalStyle, SelectedStyle>: ButtonStyle
where NormalStyle: ButtonStyle, SelectedStyle: ButtonStyle {
    /// The button style to apply when the button is not selected.
    let normalStyle: NormalStyle
    
    /// The button style to apply when the button is selected.
    let selectedStyle: SelectedStyle

    /// Reads the `isSelected` value from the environment to determine the button's state.
    /// - Note: The `isSelected` environment variable is set using the `selected(_:)` view modifier.
    @Environment(\.isSelected) var isSelected

    /// Creates a view representing the body of the button with the appropriate style.
    ///
    /// - Parameter configuration: The properties of the button being styled.
    /// - Returns: A view representing the button's styled appearance.
    func makeBody(configuration: Configuration) -> some View {
        if isSelected {
            selectedStyle.makeBody(configuration: configuration)
        } else {
            normalStyle.makeBody(configuration: configuration)
        }
    }
}

/// An extension on `View` to simplify the application of the `SelectableButtonStyle`.
extension View {
    /// Applies a selectable button style to a button, switching between two styles based on the `isSelected` environment value.
    ///
    /// This function enables a button to dynamically adjust its appearance by using the provided
    /// `normalStyle` and `selectedStyle`. The button's selected state is determined by the `isSelected`
    /// environment variable, which can be set using the `selected(_:)` view modifier.
    ///
    /// - Parameters:
    ///   - normalStyle: The button style to apply when the button is not selected.
    ///   - selectedStyle: The button style to apply when the button is selected.
    /// - Returns: A view with the selectable button style applied.
    ///
    /// - Note: Use the `selected(_:)` modifier to set the `isSelected` environment variable for
    /// a view hierarchy. This determines whether the button should render as selected.
    public func buttonStyle<NormalStyle, SelectedStyle>(
        _ normalStyle: NormalStyle,
        selected selectedStyle: SelectedStyle
    ) -> some View where NormalStyle: ButtonStyle, SelectedStyle: ButtonStyle {
        buttonStyle(SelectableButtonStyle(normalStyle: normalStyle, selectedStyle: selectedStyle))
    }
}
