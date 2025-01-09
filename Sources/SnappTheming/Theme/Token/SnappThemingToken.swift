//
//  SnappThemingToken.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

/// A wrapper for theming tokens, which can either contain a direct value or reference another token via an alias.
///
/// - `value`:  Represents a direct value of type `Value`.
/// - `alias`:  Represents a reference to another theming token, identified by a `SnappThemingTokenPath`.
public enum SnappThemingToken<Value>: Codable where Value: Codable {
    case value(Value)
    case alias(SnappThemingTokenPath)

    /// Decodes a `SnappThemingToken` from the provided decoder.
    /// - Parameter decoder: The decoder to read the data from.
    /// - Throws: A decoding error if the data cannot be decoded into a valid `SnappThemingToken`.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = if let path = try? container.decode(SnappThemingTokenPath.self) {
            .alias(path)
        } else {
            .value(try container.decode(Value.self))
        }
    }
    
    /// Encodes the `SnappThemingToken` to the provided encoder.
    /// - Parameter encoder: The encoder to write the data to.
    /// - Throws: An encoding error if the token cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .value(wrappedValue):
            try container.encode(wrappedValue)
        case let .alias(path):
            try container.encode(path)
        }
    }
}

public extension SnappThemingToken {
    /// Returns the underlying value if the token is a direct value, or `nil` if it's an alias.
    var value: Value? {
        switch self {
        case let .value(wrappedValue): wrappedValue
        case .alias: nil
        }
    }
}
