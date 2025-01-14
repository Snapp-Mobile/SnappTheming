//
//  SVGManager.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

import Foundation
import OSLog
import UIKit
import SVGKit

/// A manager class for handling SVG data and converting it to a `UIImage`.
class SVGImageDataParserManager {
    /// The rendered `UIImage` representation of the SVG data.
    private(set) var uiImage: UIImage

    /// Initializes the `SVGManager` with the provided SVG data.
    ///
    /// - Parameter data: The SVG data to be rendered into a `UIImage`.
    /// - Note: If the SVG data is invalid or cannot be rendered, a default system image is used as a fallback.
    init(data: Data) {
        if let svgImage = SVGKImage(data: data) {
            // Scale the SVG to a maximum size, maintaining its aspect ratio
            let targetSize = CGSize(
                width: max(svgImage.size.width, 512),
                height: max(svgImage.size.height, 512)
            )
            svgImage.scaleToFit(inside: targetSize)

            if let renderedImage = svgImage.uiImage {
                self.uiImage = renderedImage
            } else {
                self.uiImage = Self.defaultFallbackImage
                os_log(.error, "Failed to render SVG to UIImage. Using fallback image.")
            }
        } else {
            self.uiImage = Self.defaultFallbackImage
            os_log(.error, "Failed to parse SVG data. Using fallback image.")
        }
    }

    /// The default fallback image to use when SVG rendering fails.
    private static var defaultFallbackImage: UIImage {
        UIImage(systemName: "exclamationmark.triangle") ?? UIImage()
    }
}
