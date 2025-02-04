//
//  SegmentControlStyleTests.swift.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 28.01.2025.
//

import SwiftUI
import Testing
@testable import SnappTheming
#if canImport(UIKit)
    import UIKit
#endif

@Suite
struct SegmentControlStyleTests {
    @Test(arguments: [
        """
        {
           "segmentControlStyle": {
               "primary": {
                   "surfaceColor": "#FFFFFF0F",
                   "borderColor": {
                       "normal": "#FFFFFF1F",
                       "pressed": "#FFFFFF0F",
                       "disabled": "#FFFFFF00"
                   },
                   "selectedButtonStyle": {
                       "surfaceColor": "$colors/textBrandPrimary",
                       "borderColor": "#FFFFFF0F",
                       "textColor": "#FFFFFF",
                       "iconColor": "#FFFFFF",
                       "borderWidth": 0,
                       "typography": "$typography/textLargeSemiBold",
                       "shape": "$shapes/roundedRectangle"
                   },
                   "normalButtonStyle": {
                       "surfaceColor": "#1A1A1A",
                       "borderColor": "#FFFFFF0F",
                       "textColor": "$colors/textSecondary",
                       "iconColor": "#FFFFFF",
                       "borderWidth": 0,
                       "typography": "$typography/textLargeSemiBold",
                       "shape": "$shapes/roundedRectangle"
                   },
                   "borderWidth": 0,
                   "padding": 8,
                   "shape": "$shapes/roundedRectangle"
               }
           },
           "colors": {
               "textBrandPrimary": "#C22973",
               "textSecondary": "#7A214B"
           },
           "shapes": {
               "roundedRectangle": {
                   "type": "roundedRectangle",
                   "cornerRadius": 12,
                   "style": "circular"
               }
           },
           "typography": {
               "textLargeSemiBold": {
                   "font": \(MockJSONData.font("Roboto-Regular")),
                   "fontSize": 34
               }
           }
        }
        """
    ])
    func parseSegmentControlStyleWithSuccess(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let _ = try #require(
            declaration.segmentControlStyle.cache["primary"]?.value)
        #expect(declaration.segmentControlStyle.cache.count == 1)
        let segmentControlStyle: SnappThemingSegmentControlStyleResolver =
            declaration.segmentControlStyle.primary
        let segmentControlStyleFallbackConfiguration = declaration
            .segmentControlStyle.configuration

        let selectedButtonStyle = segmentControlStyle.selectedButtonStyle
        #expect(
            selectedButtonStyle.surfaceColor.normal
                != segmentControlStyleFallbackConfiguration
                .fallbackSelectedSegmentButtonStyle.surfaceColor.normal)
        #expect(selectedButtonStyle.borderWidth == 0)
        #expect(
            selectedButtonStyle.surfaceColor.normal == Color(hex: "#C22973"))

        let normalButtonStyle = segmentControlStyle.normalButtonStyle
        #expect(normalButtonStyle.borderWidth == 0)

        let surfaceColor = segmentControlStyle.surfaceColor
        #expect(
            surfaceColor.normal
                != segmentControlStyleFallbackConfiguration.fallbackSurfaceColor
                .normal)
        #expect(surfaceColor.normal == Color(hex: "#FFFFFF0F"))

        let borderColor = segmentControlStyle.borderColor
        #expect(
            borderColor.normal
                != segmentControlStyleFallbackConfiguration.fallbackBorderColor
                .normal)
        #expect(borderColor.normal == Color(hex: "#FFFFFF1F"))

        let borderWidth = segmentControlStyle.borderWidth
        #expect(borderWidth == 0)

        let innerPadding = segmentControlStyle.innerPadding
        #expect(
            innerPadding
                != segmentControlStyleFallbackConfiguration.fallbackInnerPadding
        )
        #expect(innerPadding == 8)
    }

    @Test(arguments: [
        """
        {
           "segmentControlStyle": {
               "primary": {
                   "surfaceColor": {
                       "normal": "#FFFFFF0F",
                       "pressed": "#3D3D3D",
                       "disabled": "#FFFFFF0F"
                   },
                   "borderColor": "#FFFFFF1F",
                   "selectedButtonStyle": {
                       "surfaceColor": "$colors/textBrandPrimary",
                       "borderColor": "#FFFFFF0F",
                       "textColor": "#FFFFFF",
                       "iconColor": "#FFFFFF",
                       "borderWidth": 0,
                       "typography": "$typography/textLargeSemiBold",
                       "shape": "$shapes/roundedRectangle"
                   },
                   "normalButtonStyle": {
                       "surfaceColor": "#1A1A1A",
                       "borderColor": "#FFFFFF0F",
                       "textColor": "$colors/textSecondary",
                       "iconColor": "#FFFFFF",
                       "borderWidth": 0,
                       "typography": "$typography/textLargeSemiBold",
                       "shape": "$shapes/roundedRectangle"
                   },
                   "borderWidth": 0,
                   "padding": 8,
                   "shape": "$shapes/roundedRectangle"
               }
           }
        }
        """
    ])
    func parseSegmentControlStyleWithWrongAliases(json: String) throws {
        let configuration = SnappThemingParserConfiguration.default

        let declaration = try SnappThemingParser.parse(
            from: json, using: configuration)
        let _ = try #require(declaration.segmentControlStyle.cache["primary"])
        #expect(declaration.segmentControlStyle.cache.count == 1)

        let segmentControlStyle: SnappThemingSegmentControlStyleResolver =
            declaration.segmentControlStyle.primary
        let segmentControlStyleFallbackConfiguration = declaration
            .segmentControlStyle.configuration

        let selectedButtonStyle = segmentControlStyle.selectedButtonStyle
        #expect(
            selectedButtonStyle.borderWidth
                == segmentControlStyleFallbackConfiguration
                .fallbackSelectedSegmentButtonStyle.borderWidth)

        let normalButtonStyle = segmentControlStyle.normalButtonStyle
        #expect(
            normalButtonStyle.borderWidth
                == segmentControlStyleFallbackConfiguration
                .fallbackNormalSegmentButtonStyle.borderWidth)

        let surfaceColor = segmentControlStyle.surfaceColor
        #expect(
            surfaceColor.normal
                == segmentControlStyleFallbackConfiguration.fallbackSurfaceColor
                .normal)

        let borderColor = segmentControlStyle.borderColor
        #expect(
            borderColor.normal
                == segmentControlStyleFallbackConfiguration.fallbackBorderColor
                .normal)

        let borderWidth = segmentControlStyle.borderWidth
        #expect(
            borderWidth
                == segmentControlStyleFallbackConfiguration.fallbackBorderWidth)

        let innerPadding = segmentControlStyle.innerPadding
        #expect(
            innerPadding
                == segmentControlStyleFallbackConfiguration.fallbackInnerPadding
        )
    }
}
