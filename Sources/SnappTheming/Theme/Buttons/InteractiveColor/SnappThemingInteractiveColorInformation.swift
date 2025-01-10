//
//  SnappThemingInteractiveColorInformation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

/// Represents the color information for interactive states (normal, pressed, and disabled).
/// This struct can either hold the individual color representations for each state or a single color applied to all states.
public struct SnappThemingInteractiveColorInformation: Codable {
    /// The color token for the normal state.
    public let normal: SnappThemingToken<SnappThemingColorRepresentation>

    /// The color token for the pressed state.
    public let pressed: SnappThemingToken<SnappThemingColorRepresentation>

    /// The color token for the disabled state.
    public let disabled: SnappThemingToken<SnappThemingColorRepresentation>

    /// Initializes the interactive color information with color tokens for each state.
    ///
    /// - Parameters:
    ///   - normal: The color token for the normal state.
    ///   - pressed: The color token for the pressed state.
    ///   - disabled: The color token for the disabled state.
    public init(normal: SnappThemingToken<SnappThemingColorRepresentation>, pressed: SnappThemingToken<SnappThemingColorRepresentation>, disabled: SnappThemingToken<SnappThemingColorRepresentation>) {
        self.normal = normal
        self.pressed = pressed
        self.disabled = disabled
    }

    /// Initializes the interactive color information with a single color token applied to all states.
    ///
    /// - Parameter singleColor: The color token to be applied to normal, pressed, and disabled states.
    public init(_ singleColor: SnappThemingToken<SnappThemingColorRepresentation>) {
        self.normal = singleColor
        self.pressed = singleColor
        self.disabled = singleColor
    }

    /// Initializes the interactive color information from a decoder. Supports both individual state colors and a single color applied to all states.
    ///
    /// - Parameter decoder: The decoder from which to initialize the interactive color information.
    public init(from decoder: any Decoder) throws {
        if let singleColor = try? decoder.singleValueContainer().decode(SnappThemingToken<SnappThemingColorRepresentation>.self) {
            // Init with all states equal to this single color
            self.normal = singleColor
            self.pressed = singleColor
            self.disabled = singleColor
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.normal = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .normal)
            self.pressed = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .pressed)
            self.disabled = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .disabled)
        }
    }
}

public extension SnappThemingInteractiveColorInformation {
    /// Resolves the interactive color information into an interactive color resolver, which provides resolved colors for the various states.
    ///
    /// - Parameters:
    ///   - colorFormat: The color format to use (e.g., ARGB, RGBA).
    ///   - colors: The color declarations used to resolve the color tokens.
    /// - Returns: A `SnappThemingInteractiveColorResolver` that provides the resolved interactive colors.
    func resolver(colorFormat: SnappThemingColorFormat, colors: SnappThemingColorDeclarations) -> SnappThemingInteractiveColorResolver {
        SnappThemingInteractiveColorResolver(normal: normal, pressed: pressed, disabled: disabled, colorFormat: colorFormat, colors: colors)
    }
}
