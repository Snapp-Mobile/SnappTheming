//
//  SnappThemingFontManager.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import CoreText
import OSLog

public final class SnappThemingFontManager {
    enum Error: Swift.Error {
        case failedToRegisterFont(at: URL)
    }

    public typealias Scope = CTFontManagerScope

    private let fileManager: FileManager
    private let scope: Scope
    private var fontCacheRootURL: URL?
    private let fontsFolderName = "fonts"

    public init(fileManager: FileManager = .default, scope: Scope = .process, themeCacheRootURL: URL?, themeName: String = "default") {
        self.fileManager = fileManager
        self.scope = scope
        
        var isDirectory: ObjCBool = true
        if let rootURL = themeCacheRootURL ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fontCacheURL = rootURL.appendingPathComponent(themeName).appendingPathComponent(fontsFolderName)
            self.fontCacheRootURL = fontCacheURL
            if !fileManager.fileExists(atPath: fontCacheURL.absoluteString, isDirectory: &isDirectory) {
                try? fileManager.createDirectory(at: fontCacheURL, withIntermediateDirectories: true)
            }
        }
    }

    public func registerFonts(_ fonts: [SnappThemingFontInformation]) {
        let availableFontPostScriptNames = getRegisteredFontsPostScriptNames()

        for font in fonts {
            guard !availableFontPostScriptNames.contains(font.postScriptName) else {
                continue
            }

            performFontRegistration(font, at: fontCacheRootURL)
        }
    }

    public func unregisterFonts(_ fonts: [SnappThemingFontInformation]) {
        var availableFontPostScriptNames = getRegisteredFontsPostScriptNames()

        for font in fonts {
            guard availableFontPostScriptNames.contains(font.postScriptName) else {
                continue
            }
            availableFontPostScriptNames.removeAll(where: { $0 == font.postScriptName })
            performFontUnregistration(font, at: fontCacheRootURL)
        }
    }

    public func registerFont(_ font: SnappThemingFontInformation) {
        let availableFontPostScriptNames = getRegisteredFontsPostScriptNames()

        guard !availableFontPostScriptNames.contains(font.postScriptName) else {
            return
        }

        performFontRegistration(font, at: fontCacheRootURL)
    }

    private func performFontRegistration(_ font: SnappThemingFontInformation, at fontsDirectoryURL: URL?) {
        do {
            let fontFileURL = try fileManager.fontFileURL(font, at: fontsDirectoryURL)
            if !fileManager.fileExists(atPath: fontFileURL.path()) {
                let fontData = font.source.data
                try fontData.write(to: fontFileURL)
            }

            let success = try registerFontsForURL(fontFileURL, scope: scope)
            if !success {
                throw Error.failedToRegisterFont(at: fontFileURL)
            }

        } catch {
            os_log(.error, "Failed to register font: \(font.postScriptName) error: \(error)")
        }
    }

    private func performFontUnregistration(_ font: SnappThemingFontInformation, at fontsDirectoryURL: URL?) {
        do {
            let fontFileURL = try fileManager.fontFileURL(font, at: fontsDirectoryURL)
            if fileManager.fileExists(atPath: fontFileURL.path()) {
                let success = try unregisterFontsForURL(fontFileURL, scope: scope)
                if !success {
                    throw Error.failedToRegisterFont(at: fontFileURL)
                }
            }


        } catch {
            os_log(.error, "Failed to register font: \(font.postScriptName) error: \(error)")
        }
    }
}

@discardableResult
fileprivate func registerFontsForURL(_ fontURL: URL, scope: SnappThemingFontManager.Scope) throws -> Bool {
    CTFontManagerRegisterFontsForURL(fontURL as CFURL, scope, nil)
}

fileprivate func getRegisteredFontsPostScriptNames() -> [String] {
    CTFontManagerCopyAvailablePostScriptNames() as! [String]
}

@discardableResult
fileprivate func unregisterFontsForURL(_ fontURL: URL, scope: SnappThemingFontManager.Scope) throws -> Bool {
    CTFontManagerUnregisterFontsForURL(fontURL as CFURL, scope, nil)
}
