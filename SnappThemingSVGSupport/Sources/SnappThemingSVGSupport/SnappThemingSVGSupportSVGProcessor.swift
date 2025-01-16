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
import UniformTypeIdentifiers
import SVGKit

/// Extension for `SnappThemingExternalImageProcessorProtocol` to provide a default implementation for SVG processing.
public extension SnappThemingExternalImageProcessorProtocol where Self == SnappThemingSVGSupportSVGProcessor {
    /// Provides a static instance of `SnappThemingSVGSupportSVGProcessor`.
    ///
    /// - Returns: A new instance of `SnappThemingSVGSupportSVGProcessor` to handle `.svg` image processing.
    static var svg: SnappThemingSVGSupportSVGProcessor { SnappThemingSVGSupportSVGProcessor() }
}

/// A processor for handling SVG image data, conforming to `SnappThemingExternalImageProcessorProtocol`.
public struct SnappThemingSVGSupportSVGProcessor: SnappThemingExternalImageProcessorProtocol {
    /// Processes the provided image data and type and converts it into a `UIImage` if the type is `.svg`.
    ///
    /// - Parameter data: Image `Data`.
    /// - Parameter type: Image `UTType`.
    /// - Returns: A `UIImage` if the processing and conversion are successful; otherwise, `nil`.
    ///
    /// - Note: This method specifically handles `.svg` type. If the type does not match, the method returns `nil`.
    /// - Warning: Ensure that the `data` is valid SVG data to avoid potential rendering issues.
    public func process(_ data: Data, of type: UTType) -> UIImage? {
        guard type == .svg else {
            os_log(.error, "Invalid type provided: %{public}@. Only .svg type is supported.", "\(type)")
            return nil
        }

        let uiImage = SnappThemingSVGSupportImageConverter(data: data).uiImage

        return uiImage
    }

    /// Initializes the `SnappThemingSVGSupportSVGProcessor`.
    ///
    /// This default initializer is used to create instances of the processor for processing SVG data.
    public init() {}
}
