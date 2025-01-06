//
//  SAThemingToken.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

public enum SAThemingToken<Value>: Codable where Value: Codable {
    case value(Value)
    case alias(SAThemingTokenPath)

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = if let path = try? container.decode(SAThemingTokenPath.self) {
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

public extension SAThemingToken {
    var value: Value? {
        switch self {
        case let .value(wrappedValue): wrappedValue
        case .alias: nil
        }
    }
}
