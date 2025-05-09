//
//  SnappThemingUnitPointWrapper.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 06.12.2024.
//

import Foundation
import SwiftUI

/// A wrapper for `UnitPoint` that enables encoding and decoding from external sources, such as JSON.
///
/// This struct is used to map different representations of `UnitPoint` values, including strings and arrays of doubles.
/// It provides a safe way to decode and encode `UnitPoint` values to handle various formats of input and output.
public struct SnappThemingUnitPointWrapper {
    /// The `UnitPoint` value representing a point on a coordinate system.
    ///
    /// It can represent values like `.center`, `.topLeading`, etc., based on the theme configuration.
    public let value: UnitPoint

    public init(value: UnitPoint) {
        self.value = value
    }
}

extension SnappThemingUnitPointWrapper: Codable {
    /// Decodes a `UnitPoint` from a given decoder, supporting both string-based and array-based formats.
    ///
    /// - Parameter decoder: The decoder used to decode the data.
    /// - Throws: An error if decoding fails.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let centerDescription = try? container.decode(String.self) {
            self.value = SnappThemingUnitPointMapper(rawValue: centerDescription).unitPoint
        } else if let centerValues = try? container.decode([Double].self) {
            self.value = SnappThemingUnitPointMapper(rawValues: centerValues).unitPoint
        } else {
            self.value = .center
        }
    }

    /// Encodes the `UnitPoint` value to a given encoder, either as a string or an array of doubles.
    ///
    /// - Parameter encoder: The encoder used to encode the data.
    /// - Throws: An error if encoding fails.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        if let rawValue = SnappThemingUnitPointMapper(unitPoint: value).rawValue {
            try container.encode(rawValue)
        } else if let rawValues = SnappThemingUnitPointMapper(unitPoint: value).rawValues {
            try container.encode(rawValues)
        }
    }
}
