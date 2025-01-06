//
//  FileManager+Extensions.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import UniformTypeIdentifiers

public extension FileManager {
    private func defaultFontsDirectoryURL() throws -> URL {
        try url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("fonts", isDirectory: true)
    }
    
    func fontFileURL(name: String, type: UTType, at fontsDirectoryURL: URL?) throws -> URL {
        let fontsDirectoryURL = try fontsDirectoryURL ?? defaultFontsDirectoryURL()

        try createDirectory(at: fontsDirectoryURL, withIntermediateDirectories: true)

        let fontFileURL = fontsDirectoryURL
            .appendingPathComponent(name, isDirectory: false)
            .appendingPathExtension(for: type)

        return fontFileURL
    }

    func fontFileURL(_ fontInformation: SAThemingFontInformation, at fontsDirectoryURL: URL?) throws -> URL {
        try fontFileURL(name: fontInformation.postScriptName, type: fontInformation.source.type, at: fontsDirectoryURL)
    }
}
