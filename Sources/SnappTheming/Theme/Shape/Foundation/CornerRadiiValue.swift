//
//  CornerRadiiValue.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SwiftUI

struct CornerRadiiValue: Codable {
    let topLeading: SnappThemingToken<Double>
    let bottomLeading: SnappThemingToken<Double>
    let bottomTrailing: SnappThemingToken<Double>
    let topTrailing: SnappThemingToken<Double>

    enum CodingKeys: String, CodingKey {
        case topLeading, bottomLeading, bottomTrailing, topTrailing
    }
}
