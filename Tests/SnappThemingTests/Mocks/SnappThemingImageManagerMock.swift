//
//  SnappThemingImageManagerMock.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SnappTheming
import UniformTypeIdentifiers

@testable import SnappTheming

final class SnappThemingImageManagerMock: SnappThemingImageManager {
    let cache: NSCache<NSString, NSData>
    private let accessQueue = DispatchQueue(label: "SharedCacheAccess")

    let image: @Sendable (Data, UTType) -> SnappThemingImage?

    init(
        cache: NSCache<NSString, NSData> = .init(),
        image: @escaping @Sendable (Data, UTType) -> SnappThemingImage? = { data, _ in
            SnappThemingImage(data: data)
        }
    ) {
        self.cache = cache
        self.image = image
    }

    func image(from data: Data, of type: UTType) -> SnappThemingImage? {
        image(data, type)
    }

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
