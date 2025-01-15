//
//  SnappThemingSVGSupportImageConverter.swift
//  SnappThemingSVGSupport
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

import Foundation
import OSLog
import UIKit
import SVGKit

/// A utility class for converts SVG data into a `UIImage`.
class SnappThemingSVGSupportImageConverter {
    /// The rendered `UIImage` representation of the SVG data.
    private(set) var uiImage: UIImage

    /// Initializes the `SnappThemingSVGSupportImageConverter` with the provided SVG data.
    ///
    /// - Parameter data: The SVG data to be rendered into a `UIImage`.
    /// - Note: If the SVG data is invalid or cannot be rendered, a default system image is used as a fallback.
    init(data: Data) {
        var svgImage: SVGKImage? = SVGKImage(data: data)

        // Retry logic for simulator or potential parsing issues
        // error: `*** Assertion failure in +[SVGLength pixelsPerInchForCurrentDevice], SVGLength.m:238`
        if svgImage == nil {
            os_log(.info, "Initial SVG parsing failed. Retrying...")
            svgImage = SVGKImage(data: data)
        }
        if let validSVGImage = svgImage {
            // Scale the SVG to a maximum size, maintaining its aspect ratio
            let targetSize = CGSize(
                width: max(validSVGImage.size.width, 512),
                height: max(validSVGImage.size.height, 512)
            )
            validSVGImage.scaleToFit(inside: targetSize)

            // Attempt to render the scaled SVG into a UIImage
            if let renderedImage = validSVGImage.uiImage {
                self.uiImage = renderedImage
            } else {
                self.uiImage = Self.defaultFallbackImage
                os_log(.error, "Failed to render SVG to UIImage after scaling. Using fallback image.")
            }
        } else {
            self.uiImage = Self.defaultFallbackImage
            os_log(.error, "Failed to parse SVG data after retry. Using fallback image.")
        }
    }

    /// The default fallback image to use when SVG rendering fails.
    private static var defaultFallbackImage: UIImage {
        UIImage(systemName: "exclamationmark.triangle") ?? UIImage()
    }
}
