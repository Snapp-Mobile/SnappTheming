//
//  RoundedCornerStyleValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

extension SnappThemingShapeRepresentation {
    /// Represents the style of rounded corners for a shape.
    ///
    /// This enum provides a mapping between raw string values and SwiftUI's `RoundedCornerStyle`.
    enum RoundedCornerStyleValue: String, Codable {
        /// A circular corner style.
        case circular
        /// A continuous corner style.
        case continuous

        /// Converts `RoundedCornerStyleValue` into SwiftUI's `RoundedCornerStyle`.
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
