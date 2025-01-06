//
//  SAThemingUnitPointMapper.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 04.12.2024.
//

import OSLog
import SwiftUI

enum SAThemingUnitPointMapper {
    case top, bottom, leading, trailing, center, topLeading, topTrailing, bottomLeading, bottomTrailing
    case custom(Double, Double)

    var unitPoint: UnitPoint {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        case .center: return .center
        case .topLeading: return .topLeading
        case .topTrailing: return .topTrailing
        case .bottomLeading: return .bottomLeading
        case .bottomTrailing: return .bottomTrailing
        case .custom(let x, let y): return UnitPoint(x: x, y: y)
        }
    }

    var rawValue: String? {
        switch self {
        case .top: return "top"
        case .bottom: return "bottom"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .center: return "center"
        case .topLeading: return "topLeading"
        case .topTrailing: return "topTrailing"
        case .bottomLeading: return "bottomLeading"
        case .bottomTrailing: return "bottomTrailing"
        case .custom: return nil
        }
    }
    var rawValues: [Double]? {
        switch self {
        case .custom(let x, let y): return [x, y]
        default: return nil
        }
    }

    init(rawValue: String) {
        switch rawValue {
        case "top": self = .top
        case "bottom": self = .bottom
        case "leading": self = .leading
        case "trailing": self = .trailing
        case "center": self = .center
        case "topLeading": self = .topLeading
        case "topTrailing": self = .topTrailing
        case "bottomLeading": self = .bottomLeading
        case "bottomTrailing": self = .bottomTrailing
        default:
            os_log("%@ is not supported. Center will be used.", rawValue)
            self = .center
        }
    }

    init(rawValues: [Double]) {
        guard
            rawValues.count == 2,
            let x = rawValues.first,
            let y = rawValues.last
        else {
            self = .center
            return
        }

        self = .custom(x, y)
    }

    init(unitPoint: UnitPoint) {
        switch unitPoint {
        case .top: self = .top
        case .bottom: self = .bottom
        case .leading: self = .leading
        case .trailing: self = .trailing
        case .center: self = .center
        case .topLeading: self = .topLeading
        case .topTrailing: self = .topTrailing
        case .bottomLeading: self = .bottomLeading
        default:
            self = .center
        }
    }
}
