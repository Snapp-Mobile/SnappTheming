//
//  SnappThemingImageProcessorsRegistry.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import Foundation

/// A registry for managing image processors in the SnappTheming framework.
///
/// ### Usage
/// ```swift
/// @main
/// struct ExampleApp: App {
///     var json: String = sampleJSON
///     let configuration: SnappThemingParserConfiguration
///
///     init() {
///         guard let themeJSON = AvailableTheme.night.json else {
///             fatalError("Couldn't find the theme JSON")
///         }
///
///         SnappThemingImageProcessorsRegistry.shared
///             .register(SnappThemingSVGSupportSVGConverter())
///
///         self.configuration = AvailableTheme.night.configuration
///
///         self.json = themeJSON
///     }
///
///     var body: some Scene {
///         WindowGroup {
///             MainView(json: json, configuration: configuration)
///         }
///     }
/// }
/// ```
public final class SnappThemingImageProcessorsRegistry: @unchecked Sendable {
    /// The default shared instance of the registry.
    /// This singleton provides a thread-safe shared instance.
    public static let shared: SnappThemingImageProcessorsRegistry = .init()

    /// A private initializer to enforce the singleton pattern.
    private init() {}

    /// An internal thread-safe array for storing external image converters.
    private var _externalImageConverters: [any SnappThemingExternalImageConverterProtocol] = []
    private let lock = NSLock()

    /// Registers a new external image converter.
    ///
    /// - Parameter converter: The image converter to register.
    /// - Discussion:
    ///   This method is thread-safe. Registered converters are stored in a private array.
    public func register(_ converter: any SnappThemingExternalImageConverterProtocol) {
        lock.lock()
        defer { lock.unlock() }
        _externalImageConverters.append(converter)
    }

    /// Retrieves all registered external image converters.
    ///
    /// - Returns: A copy of the current list of registered converters.
    /// - Discussion:
    ///   Accessing the converters is thread-safe and returns a snapshot of the current state.
    public func registeredConverters() -> [any SnappThemingExternalImageConverterProtocol] {
        lock.lock()
        defer { lock.unlock() }
        return _externalImageConverters
    }
}
