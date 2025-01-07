//
//  SnappThemingColorDeclarations.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import SwiftUI

public typealias SnappThemingColorDeclarations = SnappThemingDeclarations<SnappThemingColorRepresentation, SnappThemingColorConfiguration>

public struct SnappThemingColorConfiguration {
    public let fallbackColor: Color
    public let colorFormat: SnappThemingColorFormat
}

extension SnappThemingDeclarations where DeclaredValue == SnappThemingColorRepresentation, Configuration == SnappThemingColorConfiguration {
    public init(cache: [String: SnappThemingToken<SnappThemingColorRepresentation>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .colors,
            configuration: .init(
                fallbackColor: configuration.fallbackColor,
                colorFormat: configuration.colorFormat
            )
        )
    }

    public subscript(dynamicMember keyPath: String) -> Color {
        guard let representation: SnappThemingColorRepresentation = self[dynamicMember: keyPath] else {
            return configuration.fallbackColor
        }
        return representation.color(using: configuration.colorFormat)
    }

    public subscript(dynamicMember keyPath: String) -> UIColor {
        guard let representation: SnappThemingColorRepresentation = self[dynamicMember: keyPath] else {
            // TODO: Pick from configuration
            return .clear
        }
        return representation.uiColor(using: configuration.colorFormat)
    }
}

extension SnappThemingColorRepresentation {
    func color(using format: SnappThemingColorFormat) -> Color {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.color(using: format)
        case let .hex(hexValue):
            Color(hex: hexValue, format: format)
        }
    }

    func uiColor(using format: SnappThemingColorFormat) -> UIColor {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.uiColor(using: format)
        case let .hex(hexValue):
            UIColor(hex: hexValue, format: format)
        }
    }
}
