//
//  RoundedCornerStyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    enum RoundedCornerStyleValue: String, Codable {
        case circular, continuous

        var roundedCornerStyle: RoundedCornerStyle {
            switch self {
            case .circular:
                return .circular
            case .continuous:
                return .continuous
            }
        }
    }
}
