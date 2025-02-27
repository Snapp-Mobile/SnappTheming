//
//  FileManager+Extensions.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import OSLog
import UniformTypeIdentifiers

extension FileManager {
    private func defaultFontsDirectoryURL() throws -> URL {
        try url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("fonts", isDirectory: true)
    }

    public func fontFileURL(
        name: String, type: UTType, at fontsDirectoryURL: URL?
    ) throws -> URL {
        let fontsDirectoryURL =
            try fontsDirectoryURL ?? defaultFontsDirectoryURL()

        try createDirectory(
            at: fontsDirectoryURL, withIntermediateDirectories: true)

        let fontFileURL =
            fontsDirectoryURL
            .appendingPathComponent(name, isDirectory: false)
            .appendingPathExtension(for: type)

        return fontFileURL
    }
}
