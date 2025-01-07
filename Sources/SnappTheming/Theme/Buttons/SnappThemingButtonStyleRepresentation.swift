//
//  SnappThemingButtonStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 01.12.2024.
//

import Foundation

public struct SnappThemingButtonStyleRepresentation: Codable {
    public let surfaceColor: SnappThemingToken<SnappThemingInteractiveColorInformation>
    public let textColor: SnappThemingToken<SnappThemingInteractiveColorInformation>
    public let borderColor: SnappThemingToken<SnappThemingInteractiveColorInformation>
    public let borderWidth: SnappThemingToken<Double>
    public let shape: SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>
    public let typography: SnappThemingToken<SnappThemingTypographyRepresentation>
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let singleSurfaceColor = try? container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .surfaceColor) {
            self.surfaceColor = .init(from: singleSurfaceColor)
        } else {
            self.surfaceColor = try container.decode(SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .surfaceColor)
        }

        if let singleTextColor = try? container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .textColor) {
            self.textColor = .init(from: singleTextColor)
        } else {
            self.textColor = try container.decode(SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .textColor)
        }

        if let singleBorderColor = try? container.decode(SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .borderColor) {
            self.borderColor = .init(from: singleBorderColor)
        } else {
            self.borderColor = try container.decode(SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .borderColor)
        }

        self.borderWidth = try container.decode(SnappThemingToken<Double>.self, forKey: .borderWidth)
        self.shape = try container.decode(SnappThemingToken<SnappThemingButtonStyleShapeRepresentation>.self, forKey: .shape)
        self.typography = try container.decode(SnappThemingToken<SnappThemingTypographyRepresentation>.self, forKey: .typography)
    }
}

public extension SnappThemingButtonStyleRepresentation {
    func resolver(using configuration: SnappThemingSegmentControlStyleConfiguration) -> SnappThemingButtonStyleResolver {
        guard
            let resolvedSurfaceColor = configuration.interactiveColors.resolver
                .resolve(surfaceColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors)
                .interactiveColor,
            let resolvedTextColor = configuration.interactiveColors.resolver
                .resolve(textColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors)
                .interactiveColor,
            let resolvedBorderColor = configuration.interactiveColors.resolver
                .resolve(borderColor)?
                .resolver(colorFormat: configuration.colorFormat, colors: configuration.colors)
                .interactiveColor,
            let resolvedBorderWidth = configuration.metrics.resolver.resolve(borderWidth),
            let resolvedShape = configuration.shapes.resolver
                .resolve(shape)?
                .resolver()
                .buttonStyleType,
            let resolvedTypography = configuration.typographies.resolver.resolve(typography),
            let resolvedFont = configuration.fonts.resolver.resolve(resolvedTypography.font),
            let resolvedFontSize = configuration.metrics.resolver.resolve(resolvedTypography.fontSize)
        else {
            return .empty()
        }

        return SnappThemingButtonStyleResolver(
            surfaceColor: resolvedSurfaceColor,
            textColor: resolvedTextColor,
            borderColor: resolvedBorderColor,
            borderWidth: resolvedBorderWidth,
            shape: resolvedShape,
            typography: .init(resolvedFont.resolver, fontSize: resolvedFontSize.cgFloat)

        )
    }
}
