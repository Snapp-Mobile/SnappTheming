//
//  SnappThemingImageManagerMock.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 13.01.25.
//

import SnappTheming
import UIKit

final class SnappThemingImageManagerMock: SnappThemingImageManager {
    let cache: NSCache<NSString, UIImage> = .init()
    private let accessQueue = DispatchQueue(label: "SharedCacheAccess")

    func object(for key: String, of dataURI: SnappThemingDataURI) -> UIImage? {
        accessQueue.sync {
            cache.object(forKey: key as NSString)
        }
    }
    
    func setObject(_ object: UIImage, for key: String) {
        accessQueue.sync {
            cache.setObject(object, forKey: key as NSString)
        }
    }
    
    func store(_ dataURI: SnappThemingDataURI, for key: String) {
        // pass
    }

}
