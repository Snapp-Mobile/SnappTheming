//
//  SAThemingColorDeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 21.11.24.
//

import Foundation
import SwiftUI

public typealias SAThemingColorDeclarations = SAThemingDeclarations<SAThemingColorRepresentation, SAThemingColorConfiguration>

public struct SAThemingColorConfiguration {
    public let fallbackColor: Color
    public let colorFormat: SAThemingColorFormat
}

extension SAThemingDeclarations where DeclaredValue == SAThemingColorRepresentation, Configuration == SAThemingColorConfiguration {
    public init(cache: [String: SAThemingToken<SAThemingColorRepresentation>]?, configuration: SAThemingParserConfiguration = .default) {
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
        guard let representation: SAThemingColorRepresentation = self[dynamicMember: keyPath] else {
            return configuration.fallbackColor
        }
        return representation.color(using: configuration.colorFormat)
    }

    public subscript(dynamicMember keyPath: String) -> UIColor {
        guard let representation: SAThemingColorRepresentation = self[dynamicMember: keyPath] else {
            // TODO: Pick from configuration
            return .clear
        }
        return representation.uiColor(using: configuration.colorFormat)
    }
}

extension SAThemingColorRepresentation {
    func color(using format: SAThemingColorFormat) -> Color {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.color(using: format)
        case let .hex(hexValue):
            Color(hex: hexValue, format: format)
        }
    }

    func uiColor(using format: SAThemingColorFormat) -> UIColor {
        switch self {
        case let .dynamic(dynamicColor):
            dynamicColor.uiColor(using: format)
        case let .hex(hexValue):
            UIColor(hex: hexValue, format: format)
        }
    }
}
