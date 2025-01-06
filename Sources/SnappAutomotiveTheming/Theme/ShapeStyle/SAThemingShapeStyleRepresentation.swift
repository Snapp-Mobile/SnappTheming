//
//  SAThemingShapeStyleRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 05.12.2024.
//

import Foundation
import OSLog

public struct SAThemingShapeStyleRepresentation: Codable {
    let configuration: any SAThemingShapeStyleProviding

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let leaner = try? container.decode(SAThemingLinearGradientConfiguration.self) {
            self.configuration = leaner
        } else if let radial = try? container.decode(SAThemingRadialGradientConfiguration.self) {
            self.configuration = radial
        } else if let angular = try? container.decode(SAThemingAngularGradientConfiguration.self) {
            self.configuration = angular
        } else {
            os_log("Not supported gradient type found in %@. Defaulting to clear gradient", container.codingPath)
            self.configuration = SAThemingClearShapeStyleConfiguration()
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(configuration)
    }
}
