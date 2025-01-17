//
//  ViewSelection.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 10.01.2025.
//

import SwiftUI

/// Adds a custom `isSelected` property to the `EnvironmentValues` structure,
/// allowing views to access or modify this value using the environment.
extension EnvironmentValues {
    /// A Boolean value indicating whether a view is selected.
    ///
    /// Default value is `false`.
#if swift(>=6.0)
    @Entry public var isSelected = false
#else
    var isSelected: Bool {
            get {
                self[PrimaryThemeKey.self]
            }
            set {
                self[PrimaryThemeKey.self] = newValue
            }
        }
#endif
}
struct PrimaryThemeKey: EnvironmentKey {
    static var defaultValue: Bool { false }
}

/// Extends `View` to include a modifier for setting the `isSelected` property
/// in the environment.
extension View {
    /// Sets the `isSelected` value in the environment for the current view and its children.
    ///
    /// - Parameter isSelected: A Boolean value to assign to the `isSelected` environment property.
    /// - Returns: A view that has the modified environment value.
    ///
    /// Example usage:
    /// ```swift
    /// struct ParentView: View {
    ///     var body: some View {
    ///         ChildView()
    ///             .selected(true) // Apply the `selected` modifier to the parent view
    ///     }
    /// }
    ///
    /// struct ChildView: View {
    ///     @Environment(\.isSelected) private var isSelected
    ///
    ///     var body: some View {
    ///         Text(isSelected ? "Selected" : "Not Selected")
    ///             .padding()
    ///             .background(isSelected ? Color.green : Color.gray)
    ///             .cornerRadius(8)
    ///     }
    /// }
    /// ```
    public func selected(_ isSelected: Bool) -> some View {
        Text("")
//        environment(\.isSelected, isSelected)
    }
}
