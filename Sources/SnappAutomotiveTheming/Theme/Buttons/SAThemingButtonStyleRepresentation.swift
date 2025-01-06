//
//  ButtonStyleRepresentation.swift
//  SnappAutomotiveTheming
//
//  Created by Oleksii Kolomiiets on 01.12.2024.
//

import Foundation

public struct SAThemingButtonStyleRepresentation: Codable {
    public let surfaceColor: SAThemingToken<SAThemingInteractiveColorInformation>
    public let textColor: SAThemingToken<SAThemingInteractiveColorInformation>
    public let borderColor: SAThemingToken<SAThemingInteractiveColorInformation>
    public let borderWidth: SAThemingToken<Double>
    public let shape: SAThemingToken<SAThemingButtonStyleShapeRepresentation>
    public let typography: SAThemingToken<SAThemingTypographyRepresentation>
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let singleSurfaceColor = try? container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .surfaceColor) {
            self.surfaceColor = .init(from: singleSurfaceColor)
        } else {
            self.surfaceColor = try container.decode(SAThemingToken<SAThemingInteractiveColorInformation>.self, forKey: .surfaceColor)
        }

        if let singleTextColor = try? container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .textColor) {
            self.textColor = .init(from: singleTextColor)
        } else {
            self.textColor = try container.decode(SAThemingToken<SAThemingInteractiveColorInformation>.self, forKey: .textColor)
        }

        if let singleBorderColor = try? container.decode(SAThemingToken<SAThemingColorRepresentation>.self, forKey: .borderColor) {
            self.borderColor = .init(from: singleBorderColor)
        } else {
            self.borderColor = try container.decode(SAThemingToken<SAThemingInteractiveColorInformation>.self, forKey: .borderColor)
        }

        self.borderWidth = try container.decode(SAThemingToken<Double>.self, forKey: .borderWidth)
        self.shape = try container.decode(SAThemingToken<SAThemingButtonStyleShapeRepresentation>.self, forKey: .shape)
        self.typography = try container.decode(SAThemingToken<SAThemingTypographyRepresentation>.self, forKey: .typography)
    }
}

public extension SAThemingButtonStyleRepresentation {
    func resolver(using configuration: SAThemingSegmentControlStyleConfiguration) -> SAThemingButtonStyleResolver {
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

        return SAThemingButtonStyleResolver(
            surfaceColor: resolvedSurfaceColor,
            textColor: resolvedTextColor,
            borderColor: resolvedBorderColor,
            borderWidth: resolvedBorderWidth,
            shape: resolvedShape,
            typography: .init(resolvedFont.resolver, fontSize: resolvedFontSize.cgFloat)

        )
    }
}
