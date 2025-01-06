//
//  SAThemingTokenPath.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

public struct SAThemingTokenPath: Codable, Equatable {
    private static let prefix = "$"
    private static let separator = "/"

    private enum DecodingError: Error {
        case failedToParsePath
    }

    public let component: String
    public let name: String

    public init(component: String, name: String) {
        self.component = component
        self.name = name
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let path = try container.decode(String.self)
        guard
            path.starts(with: Self.prefix),
            path.contains(Self.separator),
            let pathComponents = path
                .split(separator: Self.prefix).last?
                .split(separator: Self.separator),
            pathComponents.count == 2
        else {
            throw DecodingError.failedToParsePath
        }
        self.init(component: String(pathComponents[0]), name: String(pathComponents[1]))
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Self.prefix + component + Self.separator + name)
    }
}
