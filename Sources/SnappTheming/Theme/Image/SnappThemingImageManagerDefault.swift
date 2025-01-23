//
//  SnappThemingImageManagerDefault.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

import Foundation
import OSLog
import UIKit
import UniformTypeIdentifiers

/// An enumeration of possible errors in `SnappThemingImageManager`.
private enum ImagesManagerError: Error {
    /// Indicates that the images directory URL is unknown or inaccessible.
    case unknownImagesDirectoryURL

    /// Indicates that the MIME type for the image is unknown or unsupported.
    case unknownMIMEType
}

extension NSCache: @retroactive @unchecked Sendable {}
extension FileManager: @retroactive @unchecked Sendable {}

/// A manager for handling themed image caching and persistent storage.
///
/// This class is designed to work with `SnappThemingDataURI` objects for handling image data along with their MIME types.
///
/// ### Note
/// All file operations are confined to a dedicated directory to ensure security and prevent unauthorized file access.
public final class SnappThemingImageManagerDefault: SnappThemingImageManager {
    private let cache: NSCache<NSString, UIImage> = .init()
    private let fileManager: FileManager
    private let imageCacheRootURL: URL?
    private let imagesFolderName = "images"
    private let accessQueue = DispatchQueue(label: "SharedCacheAccess")

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
        } else {
            self.imageCacheRootURL = nil
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
        of dataURI: SnappThemingDataURI
    ) -> UIImage? {
        accessQueue.sync {
            do {
                if let cachedImage = cache.object(forKey: key as NSString) {
                    return cachedImage
                } else if let imageURL = imageCacheURL(for: key, of: dataURI),
                    fileManager.fileExists(atPath: imageURL.path())
                {
                    let data = try Data(contentsOf: imageURL)
                    return image(from: data, of: dataURI.type)
                }
                return nil
            } catch let error {
                os_log(.error, "Error getting object for key \"%@\": %@", key, error.localizedDescription)
                return nil
            }
        }
    }

    /// Processes image `Data` and `UIType` to generate a corresponding `UIImage`.
    ///
    /// - Parameter data: Image `Data`.
    /// - Parameter type: Image `UTType`.
    /// - Returns: A `UIImage` created from the provided representation, or `nil` if the conversion fails.
    ///
    /// This function handles different image formats based on their type:
    /// - For `.pdf`: Converts the PDF data to a `UIImage`.
    /// - For `.png` or `.jpeg`: Converts the data directly to a `UIImage` using `UIImage(data:)`.
    /// - For other formats: Delegates the conversion to registered external image processors.
    ///
    /// - Warning: Make sure to validate `data` in external processors to prevent potential issues with corrupted or malicious data.
    /// See how register external processors ``SnappThemingImageProcessorsRegistry``.
    public func image(from data: Data, of type: UTType) -> UIImage? {
        let dataURI = "data:\(String(describing: type.preferredMIMEType));\(data.base64EncodedString())"

        switch type {
        case .pdf:
            guard let pdfImage = UIImage.pdf(data: data) else {
                os_log(.error, "Failed to process PDF data into an image. DataURI: %@.", dataURI)
                return nil
            }
            return pdfImage

        case .png, .jpeg:
            guard let image = UIImage(data: data) else {
                os_log(.error, "Failed to process PNG/JPEG data into image. DataURI: %@.", dataURI)
                return nil
            }
            return image

        default:
            let processors = SnappThemingImageProcessorsRegistry.shared.registeredProcessors()
            for processor in processors {
                if let processedImage = processor.process(data, of: type) {
                    return processedImage
                }
            }
            os_log(.error, "No suitable processor found for dataURI: %@.", dataURI)
            return nil
        }
    }

    /// Caches an image in memory.
    ///
    /// - Parameters:
    ///   - object: The `UIImage` to cache.
    ///   - key: The unique key associated with the image.
    public func setObject(_ object: UIImage, for key: String) {
        accessQueue.sync {
            cache.setObject(object, forKey: key as NSString)
        }
    }

    /// Stores an image persistently on disk.
    ///
    /// - Parameters:
    ///   - dataURI: A `SnappThemingDataURI` object containing the image data and MIME type.
    ///   - key: The unique key associated with the image.
    public func store(_ dataURI: SnappThemingDataURI, for key: String) {
        accessQueue.sync {
            guard let imageURL = imageCacheURL(for: key, of: dataURI) else { return }
            do {
                try dataURI.data.write(to: imageURL, options: .atomic)
            } catch let error {
                os_log(.error, "Error storing data for key \"%@\": %@", key, error.localizedDescription)
            }
        }
    }

    private func imageCacheURL(for key: String, of dataURI: SnappThemingDataURI) -> URL? {
        guard let imageCacheRootURL else { return nil }
        return
            imageCacheRootURL
            .appending(path: key)
            .appendingPathExtension(for: dataURI.type)
    }
}
