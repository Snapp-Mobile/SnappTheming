//
//  SnappThemingUnitPointWrapper.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 06.12.2024.
//

import Foundation
import SwiftUI

public struct SnappThemingUnitPointWrapper {
    public let value: UnitPoint
}

extension SnappThemingUnitPointWrapper: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let centerDescription = try? container.decode(String.self) {
            self.value = SnappThemingUnitPointMapper(rawValue: centerDescription).unitPoint
        } else if let centerValues = try? container.decode([Double].self) {
            self.value = SnappThemingUnitPointMapper(rawValues: centerValues).unitPoint
        } else {
            self.value = .center
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        if let rawValue = SnappThemingUnitPointMapper(unitPoint: value).rawValue {
            try container.encode(rawValue)
        } else if let rawValues = SnappThemingUnitPointMapper(unitPoint: value).rawValues {
            try container.encode(rawValues)
        }
    }
}
