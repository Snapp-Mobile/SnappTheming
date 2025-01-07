//
//  SnappThemingShapeStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import Foundation
import OSLog

public struct SnappThemingShapeStyleRepresentation: Codable {
    let configuration: any SnappThemingShapeStyleProviding

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let leaner = try? container.decode(SnappThemingLinearGradientConfiguration.self) {
            self.configuration = leaner
        } else if let radial = try? container.decode(SnappThemingRadialGradientConfiguration.self) {
            self.configuration = radial
        } else if let angular = try? container.decode(SnappThemingAngularGradientConfiguration.self) {
            self.configuration = angular
        } else {
            os_log("Not supported gradient type found in %@. Defaulting to clear gradient", container.codingPath)
            self.configuration = SnappThemingClearShapeStyleConfiguration()
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(configuration)
    }
}
