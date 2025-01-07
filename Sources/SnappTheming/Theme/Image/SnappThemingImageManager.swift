//
//  SnappThemingImageManager.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

import Foundation
import OSLog
import UIKit

public final class SnappThemingImageManager {
    enum ImagesManagerError: Error {
        case unknownImagesDirectoryURL
        case unknownMIMEType
    }

    private let cache: NSCache<NSString, UIImage> = .init()
    private var fileManager: FileManager
    private var imageCacheRootURL: URL?
    private let imagesFolderName = "images"

    init(_ fileManager: FileManager = .default, themeCacheRootURL: URL? = nil, themeName: String = "default") {
        self.fileManager = fileManager
        var isDirectory: ObjCBool = true
        if let rootURL = themeCacheRootURL ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageCacheRootURL = rootURL.appendingPathComponent(themeName).appendingPathComponent(imagesFolderName)
            self.imageCacheRootURL = imageCacheRootURL
            if !fileManager.fileExists(atPath: imageCacheRootURL.absoluteString, isDirectory: &isDirectory) {
                try? fileManager.createDirectory(at: imageCacheRootURL, withIntermediateDirectories: true)
            }
        }
    }

    func object(for key: String, of dataURI: SnappThemingDataURI) -> UIImage? {
        do {
            if let cachedImage = cache.object(forKey: key as NSString) {
                return cachedImage
            } else if let imageURL = imageCacheURL(for: key, of: dataURI), fileManager.fileExists(atPath: imageURL.path()) {
                let data = try Data(contentsOf: imageURL)
                return .from(data, of: dataURI.type)
            }
            return nil
        } catch let error {
            os_log(.error, "Error getting object for key \"%@\": %@", key, error.localizedDescription)
            return nil
        }
    }

    func setObject(_ object: UIImage, for key: String) {
        cache.setObject(object, forKey: key as NSString)
    }

    func store(_ dataURI: SnappThemingDataURI, for key: String) {
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
