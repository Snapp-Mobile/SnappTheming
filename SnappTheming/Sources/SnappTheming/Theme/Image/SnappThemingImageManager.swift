//
//  SnappThemingImageManager.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

import Foundation
import OSLog
import UIKit
import UniformTypeIdentifiers
class SVGSnappThemingImageManager: SnappThemingImageManager {
    override func from(_ data: Data, of type: UTType) -> UIImage? {
        switch type {
        case .svg: nil
        default: super.from(data, of: type)
        }
    }
}

/// A manager for handling themed image caching and persistent storage.
///
/// This class is designed to work with `SnappThemingDataURI` objects for handling image data along with their MIME types.
///
/// ### Note
/// All file operations are confined to a dedicated directory to ensure security and prevent unauthorized file access.
public class SnappThemingImageManager {
    func from(_ dataURI: SnappThemingDataURI) -> UIImage? {
        from(dataURI.data, of: dataURI.type)
    }

    func from(_ data: Data, of type: UTType) -> UIImage? {
        switch type {
        case .pdf: .pdf(data: data)
        case .png, .jpeg: .init(data: data)
        default: nil
        }
    }
    /// An enumeration of possible errors in `SnappThemingImageManager`.
    public enum ImagesManagerError: Error {
        /// Indicates that the images directory URL is unknown or inaccessible.
        case unknownImagesDirectoryURL

        /// Indicates that the MIME type for the image is unknown or unsupported.
        case unknownMIMEType
    }

    private let cache: NSCache<NSString, UIImage> = .init()
    private var fileManager: FileManager
    private(set) var imageCacheRootURL: URL?
    private(set) var themeName: String
    private let imagesFolderName = "images"

    /// Initializes the image manager with optional custom parameters.
    ///
    /// - Parameters:
    ///   - fileManager: The file manager to use for file operations. Defaults to `.default`.
    ///   - themeCacheRootURL: The root URL for theme caching. Defaults to the app's documents directory if `nil`.
    ///   - themeName: The name of the theme for organizing cached images. Defaults to `"default"`.
    public init(
        _ fileManager: FileManager = .default,
        themeCacheRootURL: URL? = nil,
        themeName: String = "default"
    ) {
        self.fileManager = fileManager
        self.themeName = themeName
        var isDirectory: ObjCBool = true
        if let rootURL = themeCacheRootURL ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageCacheRootURL = rootURL.appendingPathComponent(themeName).appendingPathComponent(imagesFolderName)
            self.imageCacheRootURL = imageCacheRootURL
            if !fileManager.fileExists(atPath: imageCacheRootURL.absoluteString, isDirectory: &isDirectory) {
                do {
                    try fileManager.createDirectory(at: imageCacheRootURL, withIntermediateDirectories: true)
                } catch {
                    os_log(.error, "Failed to create image cache directory: %@", imageCacheRootURL.absoluteString)
                }
            }
        }
    }

    /// Retrieves an image from the cache or storage.
    ///
    /// - Parameters:
    ///   - key: The unique key identifying the image.
    ///   - dataURI: A `SnappThemingDataURI` object containing the image data and MIME type.
    /// - Returns: The retrieved `UIImage` or `nil` if not found.
    public func object(
        for key: String,
        of dataURI: SnappThemingDataURI,
        convert: @escaping (Data, SnappThemingDataURI) -> UIImage?
    ) -> UIImage? {
        do {
            if let cachedImage = cache.object(forKey: key as NSString) {
                return cachedImage
            } else if let imageURL = imageCacheURL(for: key, of: dataURI), fileManager.fileExists(atPath: imageURL.path()) {
                let data = try Data(contentsOf: imageURL)
                return convert(data, dataURI)
            }
            return nil
        } catch let error {
            os_log(.error, "Error getting object for key \"%@\": %@", key, error.localizedDescription)
            return nil
        }
    }

    /// Caches an image in memory.
    ///
    /// - Parameters:
    ///   - object: The `UIImage` to cache.
    ///   - key: The unique key associated with the image.
    public func setObject(_ object: UIImage, for key: String) {
        cache.setObject(object, forKey: key as NSString)
    }

    /// Stores an image persistently on disk.
    ///
    /// - Parameters:
    ///   - dataURI: A `SnappThemingDataURI` object containing the image data and MIME type.
    ///   - key: The unique key associated with the image.
    public func store(_ dataURI: SnappThemingDataURI, for key: String) {
        guard let imageURL = imageCacheURL(for: key, of: dataURI) else { return }
        do {
            try dataURI.data.write(to: imageURL, options: .atomic)
        } catch let error {
            os_log(.error, "Error storing data for key \"%@\": %@", key, error.localizedDescription)
        }
    }

    private func imageCacheURL(for key: String, of dataURI: SnappThemingDataURI) -> URL? {
        guard let imageCacheRootURL else { return nil }
        return imageCacheRootURL
            .appending(path: key)
            .appendingPathExtension(for: dataURI.type)
    }
}
