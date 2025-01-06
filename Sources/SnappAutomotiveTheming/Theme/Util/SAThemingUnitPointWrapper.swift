//
//  SAThemingUnitPointWrapper.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 06.12.2024.
//

import Foundation
import SwiftUI

public struct SAThemingUnitPointWrapper {
    public let value: UnitPoint
}

extension SAThemingUnitPointWrapper: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let centerDescription = try? container.decode(String.self) {
            self.value = SAThemingUnitPointMapper(rawValue: centerDescription).unitPoint
        } else if let centerValues = try? container.decode([Double].self) {
            self.value = SAThemingUnitPointMapper(rawValues: centerValues).unitPoint
        } else {
            self.value = .center
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        if let rawValue = SAThemingUnitPointMapper(unitPoint: value).rawValue {
            try container.encode(rawValue)
        } else if let rawValues = SAThemingUnitPointMapper(unitPoint: value).rawValues {
            try container.encode(rawValues)
        }
    }
}
