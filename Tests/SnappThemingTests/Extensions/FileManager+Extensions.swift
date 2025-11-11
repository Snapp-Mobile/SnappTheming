//
//  File.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/8/25.
//

import Foundation

extension FileManager {
    static let withFileExistTrue: MockFileManager = { withFileExistTrue() }()
    static func withFileExistTrue(
        _ createDirectoryError: MockFileManager.FileManagerError? = nil,
        cachedURLs: [URL] = []
    ) -> MockFileManager {
        let fileManager = MockFileManager()
        fileManager.fileExists = true
        fileManager.urlsResult = cachedURLs
        fileManager.createDirectoryError = createDirectoryError
        return fileManager
    }

    static let emptyCacheDirectory: MockFileManager = {
        let fileManager = MockFileManager()
        fileManager.urlsResult = []
        return fileManager
    }()
}
