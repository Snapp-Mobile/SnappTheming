//
//  SnappThemingToken.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

public enum SnappThemingToken<Value>: Codable where Value: Codable {
    case value(Value)
    case alias(SnappThemingTokenPath)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = if let path = try? container.decode(SnappThemingTokenPath.self) {
            .alias(path)
        } else {
            .value(try container.decode(Value.self))
        }
    }

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
    var value: Value? {
        switch self {
        case let .value(wrappedValue): wrappedValue
        case .alias: nil
        }
    }
}
