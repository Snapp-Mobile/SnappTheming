//
//  SnappThemingImageManager.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 16.01.2025.
//

import Foundation
import UniformTypeIdentifiers

/// A protocol defining the responsibilities of a theming image manager,
/// enabling image handling, caching, and storage for theming purposes.
public protocol SnappThemingImageManager: Sendable {
    /// Retrieves an image object associated with a given key and data URI.
    ///
    /// - Parameters:
    ///   - key: A `String` representing the unique key associated with the image.
    ///   - dataURI: A `SnappThemingDataURI` containing the data and type information of the image.
    /// - Returns: A `SnappThemingImageObject` if an object for the given key and data URI is available; otherwise, `nil`.
    func object(for key: String, of dataURI: SnappThemingDataURI) -> SnappThemingImageObject?

    /// Converts an image object into a `SnappThemingImage` based on the specified type.
    ///
    /// - Parameters:
    ///   - object: The `SnappThemingImageObject` containing the image data and optional source URL context.
    ///   - type: The `UTType` indicating the type of the image (e.g., `.png`, `.jpeg`, `.svg`).
    /// - Returns: A `SnappThemingImage` if the conversion is successful; otherwise, `nil`.
    func image(from object: SnappThemingImageObject, of type: UTType) -> SnappThemingImage?

    /// Stores a `Data` object in the image manager associated with the given key.
    ///
    /// - Parameters:
    ///   - object: The `Data` to store.
    ///   - key: A `String` representing the unique key to associate with the image.
    func setObject(_ object: Data, for key: String)

    /// Stores a `SnappThemingDataURI` representation in the image manager for a given key.
    ///
    /// - Parameters:
    ///   - dataURI: The `SnappThemingDataURI` containing the data and type information of the image.
    ///   - key: A `String` representing the unique key to associate with the data URI.
    func store(_ dataURI: SnappThemingDataURI, for key: String)
}
