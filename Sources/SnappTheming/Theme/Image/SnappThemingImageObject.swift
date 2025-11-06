//
//  SnappThemingImageObject.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/5/25.
//

import Foundation

/// A container for image data with optional source URL context.
///
/// `SnappThemingImageObject` encapsulates raw image data alongside optional URL information,
/// enabling image processors to access resource context when rendering.
public struct SnappThemingImageObject {
    /// The raw image data.
    ///
    /// Contains the encoded image content (e.g., SVG XML, PNG bytes, etc.).
    public var data: Data

    /// The URL source of the image data, if available.
    ///
    /// Providing a URL helps image processors understand the resource context,
    /// which is essential for formats that support relative file references.
    /// For SVG images, this URL enables proper handling of relative links
    /// within the SVG content.
    ///
    /// When `nil`, image processors must work with data alone, which may
    /// limit functionality for certain formats.
    public var url: URL?

    /// Creates an image object with data and optional URL.
    ///
    /// - Parameters:
    ///   - data: The raw image data.
    ///   - url: The source URL of the image data. Defaults to `nil`.
    ///
    /// This initializer always succeeds and is the primary way to create
    /// an `ImageObject` from existing data.
    ///
    /// ## Example
    /// ```swift
    /// let svgData = try Data(contentsOf: themePath)
    /// let imageObj = ImageObject(data: svgData, url: themePath)
    /// ```
    public init(data: Data, url: URL? = nil) {
        self.data = data
        self.url = url
    }

    /// Creates an image object with optional data and URL.
    ///
    /// - Parameters:
    ///   - data: The raw image data. Returns `nil` if data is `nil`.
    ///   - url: The source URL of the image data.
    ///
    /// - Returns: An initialized `ImageObject` if data is provided; `nil` otherwise.
    ///
    /// This initializer is useful for handling optional data sources where
    /// a missing data value should result in a failed initialization.
    ///
    /// ## Example
    /// ```swift
    /// if let imageObj = ImageObject(data: optionalSVGData, url: sourceURL) {
    ///     // Use imageObj
    /// }
    /// ```
    public init?(data: Data?, url: URL?) {
        guard let data else {
            return nil
        }

        self.init(data: data, url: url)
    }

    /// Creates an image object by loading data from a file URL.
    ///
    /// - Parameter url: The file URL to load image data from.
    ///
    /// - Throws: An error if the file cannot be read.
    ///
    /// This initializer is convenient for loading images from bundle resources
    /// or disk while automatically preserving the source URL for context.
    ///
    /// ## Example
    /// ```swift
    /// let imageObj = try ImageObject(url: bundledSVGURL)
    /// ```
    public init(url: URL) throws {
        let data = try Data(contentsOf: url)

        self.init(data: data, url: url)
    }
}
