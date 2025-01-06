//
//  ButtonStyleShape.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import OSLog
import SwiftUI

public struct SAThemingButtonStyleShape: Codable, Sendable {
    public let width: Double?
    public let height: Double?
    public let cornerRadius: Double
    public let padding: [Double]?

    public var resolvedWidth: Double {
        width ?? 0
    }
    public var resolvedHeight: Double {
        height ?? 0
    }

    public var resolvedPadding: EdgeInsets {
        guard let padding else { return EdgeInsets() }
        switch padding.count {
        case 1: return EdgeInsets(top: padding[0], leading: padding[0], bottom: padding[0], trailing: padding[0])
        case 2: return EdgeInsets(top: padding[0], leading: padding[1], bottom: padding[0], trailing: padding[1])
        case 4: return EdgeInsets(top: padding[0], leading: padding[1], bottom: padding[2], trailing: padding[3])
        default:
            return EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        }
    }

    public init(width: Double = .zero, height: Double = .zero, cornerRadius: Double = .zero, padding: [Double] = [.zero]) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.padding = padding
    }

    public init(
        width: SAThemingToken<Double>,
        height: SAThemingToken<Double>,
        cornerRadius: SAThemingToken<Double>,
        padding: SAThemingToken<[Double]>,
        metrics: SAThemingMetricDeclarations
    ) {
        guard
            let width = metrics.resolver.resolve(width),
            let height = metrics.resolver.resolve(height),
            let cornerRadius = metrics.resolver.resolve(cornerRadius),
            let padding = padding.value
        else {
            self.init()
            return
        }
        self.init(width: width, height: height, cornerRadius: cornerRadius, padding: padding)
    }
}
