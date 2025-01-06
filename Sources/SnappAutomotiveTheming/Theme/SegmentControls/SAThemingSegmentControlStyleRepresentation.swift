//
//  SAThemingSegmentControlStyleRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 09.12.2024.
//

import Foundation

public struct SAThemingSegmentControlStyleRepresentation: Codable {
    public let selectedButtonStyle: SAThemingToken<SAThemingButtonStyleRepresentation>
    public let normalButtonStyle: SAThemingToken<SAThemingButtonStyleRepresentation>

    public let surfaceColor: SAThemingToken<SAThemingInteractiveColorInformation>
    public let borderColor: SAThemingToken<SAThemingInteractiveColorInformation>
    public let borderWidth: SAThemingToken<Double>
    public let padding: SAThemingToken<Double>
    public let shape: SAThemingToken<SAThemingButtonStyleShapeRepresentation>

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedButtonStyle = try container.decode(SAThemingToken<SAThemingButtonStyleRepresentation>.self, forKey: .selectedButtonStyle)
        self.normalButtonStyle = try container.decode(SAThemingToken<SAThemingButtonStyleRepresentation>.self, forKey: .normalButtonStyle)
        self.borderWidth = try container.decode(SAThemingToken<Double>.self, forKey: .borderWidth)
        self.padding = try container.decode(SAThemingToken<Double>.self, forKey: .padding)
        self.shape = try container.decode(SAThemingToken<SAThemingButtonStyleShapeRepresentation>.self, forKey: .shape)

        if let singleSurfaceColor = try? container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .surfaceColor) {
            self.surfaceColor = .init(from: singleSurfaceColor)
        } else {
            self.surfaceColor = try container.decode(SAThemingToken<SAThemingInteractiveColorInformation>.self, forKey: .surfaceColor)
        }
        if let singleBorderColor = try? container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .borderColor) {
            self.borderColor = .init(from: singleBorderColor)
        } else {
            self.borderColor = try container.decode(SAThemingToken<SAThemingInteractiveColorInformation>.self, forKey: .borderColor)
        }
    }
}
