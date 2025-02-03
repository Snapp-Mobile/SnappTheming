//
//  SnappThemingGradientRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import Foundation
import OSLog

/// A representation of a shape style configuration in SnappTheming framework,
/// which can include various gradient types.
///
/// `SnappThemingGradientRepresentation` encodes and decodes a shape style configuration based
/// on a provided theme. It supports different gradient types (linear, radial, and angular),
/// and defaults to a clear shape style if the gradient type is unsupported.
///
/// ### Supported Gradient Types:
/// - **Linear Gradient**: A gradient that transitions smoothly between two or more colors along a straight line.
/// - **Radial Gradient**: A gradient that transitions from a central point outwards in a circular pattern.
/// - **Angular Gradient**: A gradient that transitions along an angular direction around a central point.
///
/// If an unsupported gradient type is encountered during decoding, it defaults
/// to a `SnappThemingClearShapeStyleConfiguration` with a clear shape style.

public struct SnappThemingGradientRepresentation: Codable {
    /// The shape style configuration used for defining the visual appearance of a shape.
    ///
    /// This property holds an instance of a type conforming to the `SnappThemingShapeStyleProviding`
    /// protocol, which provides the shape style to be applied to a shape. The exact shape style
    /// can be determined dynamically, depending on the implementation of the configuration type.
    /// The configuration could be a specific type of gradient (linear, radial, angular), or a fallback
    /// clear style if no supported configuration is found during decoding.
    ///
    /// The `configuration` is encoded and decoded as part of the `SnappThemingShapeStyleRepresentation`
    /// to ensure persistence or transmission of the shape style data across different systems or components.
    ///
    /// - See Also: ``SnappThemingGradientProviding``, ``SnappThemingLinearGradientConfiguration``,
    ///  ``SnappThemingRadialGradientConfiguration``, ``SnappThemingAngularGradientConfiguration``
    public let configuration: any SnappThemingGradientProviding

    /// Initializes a `SnappThemingShapeStyleRepresentation` instance from a decoder.
    ///
    /// This initializer decodes a shape style configuration from a given decoder.
    /// It attempts to decode the shape style as one of three specific types of gradient configurations:
    /// linear, radial, or angular. If none of these types are found in the provided data, it defaults
    /// to a `SnappThemingClearShapeStyleConfiguration`, representing a clear, transparent shape style.
    ///
    /// If an unsupported gradient type is encountered, an error log is generated to indicate
    /// the issue, and a default clear style is assigned to the configuration.
    ///
    /// - Parameter decoder: The decoder used to decode the shape style configuration.
    ///
    /// - Throws: If decoding any of the expected types (linear, radial, or angular gradient) fails,
    /// or if an error occurs during decoding, this initializer will throw an error.
    /// If no supported gradient type is found, a default clear style is used without throwing an error.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let linear = try? container.decode(SnappThemingLinearGradientRepresentation.self) {
            self.configuration = linear
        } else if let radial = try? container.decode(SnappThemingRadialGradientRepresentation.self) {
            self.configuration = radial
        } else if let angular = try? container.decode(SnappThemingAngularGradientRepresentation.self) {
            self.configuration = angular
        } else {
            os_log("Not supported gradient type found in %@. Defaulting to clear gradient", container.codingPath)
            self.configuration = SnappThemingClearShapeStyleConfiguration()
        }
    }

    /// Encodes the shape style representation into the provided encoder.
    ///
    /// This method encodes the `configuration` property (which contains the shape style)
    /// into the provided encoder. It serializes the shape style configuration, allowing it
    /// to be persisted or transmitted as part of the encoded data.
    ///
    /// - Parameter encoder: The encoder used to encode the shape style configuration. The encoder
    /// must conform to the `Encoder` protocol, which can be used to encode
    /// the `configuration` property into a suitable format (e.g., JSON, Property List, etc.).
    /// - Throws: This method can throw an error if the encoding process fails, which may occur
    /// if the encoder encounters issues with serializing the configuration data.
    ///
    /// - See Also: ``SnappThemingGradientProviding``, ``SnappThemingLinearGradientConfiguration``,
    ///  ``SnappThemingRadialGradientConfiguration``, ``SnappThemingAngularGradientConfiguration``
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(configuration)
    }
}
