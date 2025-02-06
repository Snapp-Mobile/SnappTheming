//
//  SnappThemingImageManagerMock.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SnappTheming
import UniformTypeIdentifiers

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

final class SnappThemingImageManagerMock: SnappThemingImageManager {
    let cache: NSCache<NSString, NSData>
    private let accessQueue = DispatchQueue(label: "SharedCacheAccess")

    #if canImport(UIKit)
        let image: @Sendable (Data, UTType) -> UIImage?

        init(
            cache: NSCache<NSString, NSData> = .init(),
            image: @escaping @Sendable (Data, UTType) -> UIImage? = { data, _ in
                UIImage(data: data)
            }
        ) {
            self.cache = cache
            self.image = image
        }

        func image(from data: Data, of type: UTType) -> UIImage? {
            image(data, type)
        }
    #elseif canImport(AppKit)
        let image: @Sendable (Data, UTType) -> NSImage?

        init(
            cache: NSCache<NSString, NSData> = .init(),
            image: @escaping @Sendable (Data, UTType) -> NSImage? = { data, _ in
                NSImage(data: data)
            }
        ) {
            self.cache = cache
            self.image = image
        }

        func image(from data: Data, of type: UTType) -> NSImage? {
            image(data, type)
        }
    #endif

    func object(for key: String, of dataURI: SnappThemingDataURI)
        -> Data?
    {
        accessQueue.sync {
            cache.object(forKey: key as NSString) as? Data
        }
    }

    func setObject(_ object: Data, for key: String) {
        accessQueue.sync {
            cache.setObject(object as NSData, forKey: key as NSString)
        }
    }

    func store(_ dataURI: SnappThemingDataURI, for key: String) {
        // pass
    }
}
