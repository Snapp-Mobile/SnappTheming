//
//  SnappThemingTokenPath.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

/// A path that represents a reference to another theming token.
///
/// This path includes a `component` and a `name`, and is prefixed with `$` to indicate it's a reference.
///
/// Example path: `"$component/name"`.
public struct SnappThemingTokenPath: Codable, Equatable, Sendable {
    private static let prefix = "$"
    private static let separator = "/"

    private enum DecodingError: Error {
        case failedToParsePath
    }

    /// The component part of the path (e.g., the group or category of the token).
    public let component: String

    /// The name of the referenced token.
    public let name: String

    /// Initializes a `SnappThemingTokenPath` with the given component and name.
    /// - Parameters:
    ///   - component: The component part of the path.
    ///   - name: The name part of the path.
    public init(component: String, name: String) {
        self.component = component
        self.name = name
    }

    /// Decodes a `SnappThemingTokenPath` from the provided decoder.
    /// - Parameter decoder: The decoder to read the data from.
    /// - Throws: A decoding error if the path cannot be parsed correctly.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let path = try container.decode(String.self)
        guard
            path.starts(with: Self.prefix),
            path.contains(Self.separator),
            let pathComponents =
                path
                .split(separator: Self.prefix).last?
                .split(separator: Self.separator),
            pathComponents.count == 2
        else {
            throw DecodingError.failedToParsePath
        }
        self.init(component: String(pathComponents[0]), name: String(pathComponents[1]))
    }

    /// Encodes the `SnappThemingTokenPath` to the provided encoder.
    /// - Parameter encoder: The encoder to write the data to.
    /// - Throws: An encoding error if the path cannot be encoded.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Self.prefix + component + Self.separator + name)
    }
}
