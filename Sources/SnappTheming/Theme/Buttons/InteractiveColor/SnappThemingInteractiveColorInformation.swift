//
//  SnappThemingInteractiveColorInformation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 02.12.2024.
//

import Foundation

public struct SnappThemingInteractiveColorInformation: Codable {
    public let normal: SnappThemingToken<SnappThemingColorRepresentation>
    public let pressed: SnappThemingToken<SnappThemingColorRepresentation>
    public let selected: SnappThemingToken<SnappThemingColorRepresentation>
    public let disabled: SnappThemingToken<SnappThemingColorRepresentation>

    public init(normal: SnappThemingToken<SnappThemingColorRepresentation>, pressed: SnappThemingToken<SnappThemingColorRepresentation>, selected: SnappThemingToken<SnappThemingColorRepresentation>, disabled: SnappThemingToken<SnappThemingColorRepresentation>) {
        self.normal = normal
        self.pressed = pressed
        self.selected = selected
        self.disabled = disabled
    }

    public init(_ singleColor: SnappThemingToken<SnappThemingColorRepresentation>) {
        self.normal = singleColor
        self.pressed = singleColor
        self.selected = singleColor
        self.disabled = singleColor
    }

    public init(from decoder: any Decoder) throws {
        if let singleColor = try? decoder.singleValueContainer().decode(SnappThemingToken<SnappThemingColorRepresentation>.self) {
            // init with all states equal to this single color
            self.normal = singleColor
            self.pressed = singleColor
            self.selected = singleColor
            self.disabled = singleColor
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.normal = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .normal)
            self.pressed = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .pressed)
            self.selected = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .selected)
            self.disabled = try container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .disabled)
        }
    }
}

public extension SnappThemingInteractiveColorInformation {
    func resolver(colorFormat: SnappThemingColorFormat, colors: SnappThemingColorDeclarations) -> SnappThemingInteractiveColorResolver {
        SnappThemingInteractiveColorResolver(normal: normal, pressed: pressed, selected: selected, disabled: disabled, colorFormat: colorFormat, colors: colors)
    }
}
