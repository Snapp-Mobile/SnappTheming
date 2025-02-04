//
//  SnappThemingButtonStyleRepresentation.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 01.12.2024.
//

import Foundation
import OSLog

/// A representation of button style in the SnappTheming framework.
///
/// Encapsulates tokens for surface color, text color, border color, width, shape, and typography,
/// enabling flexible theming and styling of buttons.
public struct SnappThemingButtonStyleRepresentation: Codable {
    // MARK: - Public Properties

    /// The token representing the button's surface color in various interactive states.
    public let surfaceColor: SnappThemingToken<SnappThemingInteractiveColorInformation>

    /// The token representing the button's text color in various interactive states.
    public let textColor: SnappThemingToken<SnappThemingInteractiveColorInformation>

    /// The token representing the button's border color in various interactive states.
    public let borderColor: SnappThemingToken<SnappThemingInteractiveColorInformation>

    /// The token representing the button's border width.
    public let borderWidth: SnappThemingToken<Double>

    /// The token representing the button's shape.
    public let shape: SnappThemingToken<SnappThemingShapeRepresentation>

    /// The token representing the button's typography.
    public let typography: SnappThemingToken<SnappThemingTypographyRepresentation>

    // MARK: - Initializer

    /// Initializes a new instance of `SnappThemingButtonStyleRepresentation` by decoding values from a decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if decoding fails or the data is invalid.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            if let singleSurfaceColor = try? container.decode(
                SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .surfaceColor)
            {
                self.surfaceColor = SnappThemingToken(from: singleSurfaceColor)
            } else {
                self.surfaceColor = try container.decode(
                    SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .surfaceColor)
            }

            if let singleTextColor = try? container.decode(
                SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .textColor)
            {
                self.textColor = SnappThemingToken(from: singleTextColor)
            } else {
                self.textColor = try container.decode(
                    SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .textColor)
            }

            if let singleBorderColor = try? container.decode(
                SnappThemingToken<SnappThemingColorRepresentation>.self, forKey: .borderColor)
            {
                self.borderColor = SnappThemingToken(from: singleBorderColor)
            } else {
                self.borderColor = try container.decode(
                    SnappThemingToken<SnappThemingInteractiveColorInformation>.self, forKey: .borderColor)
            }

            self.borderWidth = try container.decode(SnappThemingToken<Double>.self, forKey: .borderWidth)
            self.shape = try container.decode(SnappThemingToken<SnappThemingShapeRepresentation>.self, forKey: .shape)
            self.typography = try container.decode(
                SnappThemingToken<SnappThemingTypographyRepresentation>.self, forKey: .typography)
        } catch {
            os_log(
                .error, "❌ Error decoding SnappThemingButtonStyleRepresentation: %{public}@", String(describing: error))
            throw error
        }
    }
}

extension SnappThemingButtonStyleRepresentation {
    public func resolver(using configuration: SnappThemingSegmentControlStyleConfiguration)
        -> SnappThemingButtonStyleResolver
    {
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
                .resolver(configuration: configuration.shapeConfiguration),
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
            typography: SnappThemingTypographyResolver(resolvedFont.resolver, fontSize: resolvedFontSize.cgFloat)

        )
    }
}
