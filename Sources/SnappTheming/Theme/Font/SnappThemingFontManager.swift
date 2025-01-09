//
//  SnappThemingFontManager.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 25.11.24.
//

import Foundation
import CoreText
import OSLog

/// A manager for dynamically registering and unregistering fonts in theming systems.
///
/// The `SnappThemingFontManager` provides an API for runtime font management, enabling dynamic registration and unregistration of custom fonts.
/// 
/// ### Note
/// All file operations are confined to a dedicated directory to ensure security and prevent unauthorized file access.
public final class SnappThemingFontManager {
    /// An enumeration of possible errors in `SnappThemingFontManager`.
    enum Error: Swift.Error {
        /// Indicates that the font registration failed at the specified URL.
        case failedToRegisterFont(at: URL)
    }

    /// The scope in which fonts are registered or unregistered. Uses Core Text's `CTFontManagerScope`.
    public typealias Scope = CTFontManagerScope

    // MARK: - Properties

    /// The file manager used for handling font files.
    private let fileManager: FileManager

    /// The scope in which fonts are registered.
    private let scope: Scope

    /// The root URL for the font cache directory.
    private var fontCacheRootURL: URL?

    /// The name of the folder where font files are stored.
    private let fontsFolderName = "fonts"

    // MARK: - Initializer

    /// Initializes a new instance of `SnappThemingFontManager`.
    ///
    /// - Parameters:
    ///   - fileManager: The file manager to use for file operations. Defaults to `.default`.
    ///   - scope: The Core Text scope for font registration. Defaults to `.process`.
    ///   - themeCacheRootURL: The root URL for theme caching. Defaults to the app's documents directory if `nil`.
    ///   - themeName: The name of the theme for font categorization. Defaults to `"default"`.
    public init(
        fileManager: FileManager = .default,
        scope: Scope = .process,
        themeCacheRootURL: URL?,
        themeName: String = "default"
    ) {
        self.fileManager = fileManager
        self.scope = scope
        
        var isDirectory: ObjCBool = true
        if let rootURL = themeCacheRootURL ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fontCacheURL = rootURL.appendingPathComponent(themeName).appendingPathComponent(fontsFolderName)
            self.fontCacheRootURL = fontCacheURL

            if !fileManager.fileExists(atPath: fontCacheURL.absoluteString, isDirectory: &isDirectory) {
                do {
                    try fileManager.createDirectory(at: fontCacheURL, withIntermediateDirectories: true)
                } catch {
                    os_log(.error, "Failed to create font cache directory: %@", fontCacheURL.absoluteString)
                }
            }
        }
    }

    // MARK: - Public Methods

    /// Registers a list of fonts.
    /// - Parameter fonts: An array of `SnappThemingFontInformation` objects to register.
    public func registerFonts(_ fonts: [SnappThemingFontInformation]) {
        let availableFontPostScriptNames = getRegisteredFontsPostScriptNames()

        for font in fonts {
            guard !availableFontPostScriptNames.contains(font.postScriptName) else {
                continue
            }

            performFontRegistration(font, at: fontCacheRootURL)
        }
    }

    /// Unregisters a list of fonts.
    /// - Parameter fonts: An array of `SnappThemingFontInformation` objects to unregister.
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

    /// Registers a single font.
    /// - Parameter font: A `SnappThemingFontInformation` object to register.
    public func registerFont(_ font: SnappThemingFontInformation) {
        let availableFontPostScriptNames = getRegisteredFontsPostScriptNames()

        guard !availableFontPostScriptNames.contains(font.postScriptName) else {
            return
        }

        performFontRegistration(font, at: fontCacheRootURL)
    }

    // MARK: - Private Methods

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
            os_log(.error, "Failed to register font: %@, error: %@", font.postScriptName, error.localizedDescription)
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
            os_log(.error, "Failed to unregister font: %@, error: %@", font.postScriptName, error.localizedDescription)
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
