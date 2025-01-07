//
//  SnappThemingSegmentControlStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SnappThemingSegmentControlStyleRepresentation: Codable {
    public let selectedButtonStyle: SnappThemingToken<SnappThemingButtonStyleRepresentation>
    public let normalButtonStyle: SnappThemingToken<SnappThemingButtonStyleRepresentation>

    public let surfaceColor: SnappThemingToken<SnappThemingInteractiveColorInformation>
    public let borderColor: SnappThemingToken<SnappThemingInteractiveColorInformation>
    public let borderWidth: SnappThemingToken<Double>
    public let padding: SnappThemingToken<Double>
    public let shape: SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedButtonStyle = try container.decode(SnappThemingToken<SnappThemingButtonStyleRepresentation>.self, forKey: .selectedButtonStyle)
        self.normalButtonStyle = try container.decode(SnappThemingToken<SnappThemingButtonStyleRepresentation>.self, forKey: .normalButtonStyle)
        self.borderWidth = try container.decode(SnappThemingToken<Double>.self, forKey: .borderWidth)
        self.padding = try container.decode(SnappThemingToken<Double>.self, forKey: .padding)
        self.shape = try container.decode(SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>.self, forKey: .shape)

        if let singleSurfaceColor = try? container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .surfaceColor) {
            self.surfaceColor = .init(from: singleSurfaceColor)
        } else {
            self.surfaceColor = try container.decode(SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .surfaceColor)
        }
        if let singleBorderColor = try? container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .borderColor) {
            self.borderColor = .init(from: singleBorderColor)
        } else {
            self.borderColor = try container.decode(SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .borderColor)
        }
    }
}
