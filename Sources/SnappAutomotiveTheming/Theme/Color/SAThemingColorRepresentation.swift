//
//  SAThemingColorRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation

public enum SAThemingColorRepresentation: Codable {
    case hex(String), dynamic(SAThemingDynamicColor)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .hex(stringValue)
        } else {
            self = try .dynamic(container.decode(SAThemingDynamicColor.self))
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .hex(let value):
            try container.encode(value)
        case .dynamic(let value):
            try container.encode(value)
        }
    }
}
