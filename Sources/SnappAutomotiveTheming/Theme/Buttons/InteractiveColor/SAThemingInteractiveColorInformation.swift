//
//  InteractiveColorInformation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SAThemingInteractiveColorInformation: Codable {
    public let normal: SAThemingToken<SAThemingColorRepresentation>
    public let pressed: SAThemingToken<SAThemingColorRepresentation>
    public let selected: SAThemingToken<SAThemingColorRepresentation>
    public let disabled: SAThemingToken<SAThemingColorRepresentation>

    public init(normal: SAThemingToken<SAThemingColorRepresentation>, pressed: SAThemingToken<SAThemingColorRepresentation>, selected: SAThemingToken<SAThemingColorRepresentation>, disabled: SAThemingToken<SAThemingColorRepresentation>) {
        self.normal = normal
        self.pressed = pressed
        self.selected = selected
        self.disabled = disabled
    }

    public init(_ singleColor: SAThemingToken<SAThemingColorRepresentation>) {
        self.normal = singleColor
        self.pressed = singleColor
        self.selected = singleColor
        self.disabled = singleColor
    }

    public init(from decoder: any Decoder) throws {
        if let singleColor = try? decoder.singleValueContainer().decode(SAThemingToken<SAThemingColorRepresentation>.self) {
            // init with all states equal to this single color
            self.normal = singleColor
            self.pressed = singleColor
            self.selected = singleColor
            self.disabled = singleColor
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.normal = try container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .normal)
            self.pressed = try container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .pressed)
            self.selected = try container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .selected)
            self.disabled = try container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .disabled)
        }
    }
}

public extension SAThemingInteractiveColorInformation {
    func resolver(colorFormat: SAThemingColorFormat, colors: SAThemingColorDeclarations) -> SAThemingInteractiveColorResolver {
        SAThemingInteractiveColorResolver(normal: normal, pressed: pressed, selected: selected, disabled: disabled, colorFormat: colorFormat, colors: colors)
    }
}
