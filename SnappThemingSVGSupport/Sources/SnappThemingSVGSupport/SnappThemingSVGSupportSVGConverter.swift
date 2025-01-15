//
//  SVGParser.swift
//  SnappThemingSVGSupport
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import Foundation
import OSLog
import SnappTheming
import UIKit
import SVGKit

/// Extension for `SnappThemingExternalImageConverterProtocol` to provide a default implementation for SVG converting.
public extension SnappThemingExternalImageConverterProtocol where Self == SnappThemingSVGSupportSVGConverter {
    /// Provides a static instance of `SnappThemingSVGSupportSVGConverter`.
    static var svg: SnappThemingSVGSupportSVGConverter { SnappThemingSVGSupportSVGConverter() }
}

/// A converter for handling SVG image data conforming to `SnappThemingExternalImageConverterProtocol`.
/// This converter specifically handles URIs of the type `.svg`.
public struct SnappThemingSVGSupportSVGConverter: SnappThemingExternalImageConverterProtocol {
    /// Converts the provided URI to a `UIImage` if it is of type `.svg`.
    ///
    /// - Parameter uri: A `SnappThemingDataURI` containing the data and type of the image.
    /// - Returns: A `UIImage` if parsing and conversion are successful; otherwise, `nil`.
    ///
    /// - Note:
    ///   - This method ensures that only URIs explicitly of type `.svg` are processed.
    ///   - The SVG data is passed to the `SnappThemingSVGSupportImageConverter` for rendering.
    ///   - Any parsing or conversion issues will result in a `nil` response, ensuring the application does not crash.
    public func converte(_ uri: SnappThemingDataURI) -> UIImage? {
        guard uri.type == .svg else {
            os_log(.error, "Invalid type provided: %{public}@. Only .svg type is supported.", "\(uri.type)")
            return nil
        }

        // Convert SVG data into a UIImage using a safe converter.
        let uiImage = SnappThemingSVGSupportImageConverter(data: uri.data).uiImage
        return uiImage
    }

    /// Initializes the `SnappThemingSVGSupportSVGConverter`.
    public init() {}
}
