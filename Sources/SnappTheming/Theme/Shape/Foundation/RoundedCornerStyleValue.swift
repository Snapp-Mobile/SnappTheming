//
//  RoundedCornerStyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

enum RoundedCornerStyleValue: String, Codable {
    case circular, continuous

    var style: RoundedCornerStyle {
        switch self {
        case .circular:
            return .circular
        case .continuous:
            return .continuous
        }
    }

    init(style: RoundedCornerStyle) {
        switch style {
        case .circular:
            self = .circular
        case .continuous:
            self = .continuous
        @unknown default:
            self = .continuous
        }
    }
}
