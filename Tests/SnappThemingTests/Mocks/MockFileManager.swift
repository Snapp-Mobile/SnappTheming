//
//  MockFileManager.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/8/25.
//

import Foundation

class MockFileManager: FileManager, @unchecked Sendable {
    enum FileManagerError: Error {
        case failedToCreateDirectory
    }
    var fileExists: Bool = false
    override func fileExists(atPath path: String) -> Bool {
        fileExists
    }

    var urlsResult: [URL] = []
    override func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        urlsResult
    }

    var createDirectoryError: Error? = nil
    override func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey : Any]? = nil) throws {
        if let createDirectoryError {
            throw createDirectoryError
        }
    }
}
