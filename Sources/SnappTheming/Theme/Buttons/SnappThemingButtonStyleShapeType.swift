//
//  SnappThemingButtonStyleShapeType.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation

enum SnappThemingButtonStyleShapeType: String, Codable {
    case circle
    case rectangle
    case ellipse
    case capsule
    case roundedRectangle
    case unevenRoundedRectangle

    init(_ rawValue: SnappThemingShapeTypeRepresentation) {
        switch rawValue {
        case .circle: self = .circle
        case .rectangle: self = .rectangle
        case .ellipse: self = .ellipse
        case .capsule: self = .capsule
        case .unevenRoundedRectangle: self = .unevenRoundedRectangle
        case .roundedRectangleWithRadius, .roundedRectangleWithSize:
            self = .roundedRectangle
        }
    }
}
