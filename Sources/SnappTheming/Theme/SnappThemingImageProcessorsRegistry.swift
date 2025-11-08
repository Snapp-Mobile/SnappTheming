//
//  SnappThemingImageProcessorsRegistry.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import Foundation

/// A registry for managing image processors in the SnappTheming framework.
///
/// Use this registry to register custom image processors that handle specific image formats
/// or transformations within the theming system. The registry maintains a thread-safe collection
/// of processors that can be accessed throughout your application's lifetime.
///
/// ## Overview
///
/// The registry follows the singleton pattern and provides thread-safe access to registered
/// image processors. Register your processors early in your application lifecycle, typically
/// in your app's initialization phase.
///
/// ## Topics
///
/// ### Getting the Shared Instance
///
/// - ``shared``
///
/// ### Managing Processors
///
/// - ``register(_:)``
/// - ``unregister(_:)``
/// - ``registeredProcessors()``
///
/// ## Usage
///
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
///             .register(SnappThemingSVGSupportSVGProcessor())
///
///         self.configuration = AvailableTheme.night.configuration
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
    /// The shared instance of the registry.
    ///
    /// Use this instance to register and access image processors throughout your application.
    /// The shared instance is thread-safe and can be accessed from any thread.
    ///
    /// ## Example
    ///
    /// ```swift
    /// SnappThemingImageProcessorsRegistry.shared.register(MyCustomProcessor())
    /// ```
    public static let shared = SnappThemingImageProcessorsRegistry()

    private init() {}

    private var _externalImageProcessors: [any SnappThemingExternalImageProcessorProtocol] = []
    private let queue = DispatchQueue(label: "ImageProcessorsQueue", attributes: .concurrent)

    /// Registers a new external image processor.
    ///
    /// This method adds a processor to the registry's collection. Processors are typically
    /// registered during application initialization and remain available throughout the
    /// app's lifetime.
    ///
    /// - Parameter processor: The image processor conforming to
    ///   ``SnappThemingExternalImageProcessorProtocol`` to register.
    ///
    /// - Note: This method is thread-safe and can be called from any thread. However,
    ///   registering processors after your UI has been initialized may lead to inconsistent
    ///   behavior. It's recommended to register all processors during app startup.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let svgProcessor = SnappThemingSVGSupportSVGProcessor()
    /// SnappThemingImageProcessorsRegistry.shared.register(svgProcessor)
    /// ```
    public func register(_ processor: any SnappThemingExternalImageProcessorProtocol) {
        queue.sync(flags: .barrier) { [weak self] in
            guard let self else { return }
            _externalImageProcessors.append(processor)
        }
    }

    /// Retrieves all currently registered external image processors.
    ///
    /// This method returns a snapshot of all processors registered at the time of the call.
    /// The returned array is a copy, so modifications to it won't affect the registry.
    ///
    /// - Returns: An array of all registered image processors conforming to
    ///   ``SnappThemingExternalImageProcessorProtocol``.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let processors = SnappThemingImageProcessorsRegistry.shared.registeredProcessors()
    /// print("Total processors registered: \(processors.count)")
    /// ```
    public func registeredProcessors() -> [any SnappThemingExternalImageProcessorProtocol] {
        queue.sync { [weak self] in
            guard let self else { return [] }
            return _externalImageProcessors
        }
    }

    /// Unregisters all image processors of a specific type.
    ///
    /// This method removes all processors from the registry that match the specified type.
    ///
    /// - Parameter processorType: The metatype of the processor to remove. Pass the type
    ///   followed by `.self` (e.g., `MyProcessor.self`).
    ///
    /// - Note: This method is thread-safe and can be called from any thread. If no processors
    ///   of the specified type are found in the registry, this method does nothing.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Register an SVG processor
    /// SnappThemingImageProcessorsRegistry.shared
    ///     .register(SnappThemingSVGSupportSVGProcessor())
    ///
    /// // Later, remove all SVG processors by type:
    /// SnappThemingImageProcessorsRegistry.shared
    ///     .unregister(SnappThemingSVGSupportSVGProcessor.self)
    /// ```
    public func unregister<T>(_ processorType: T.Type) where T: SnappThemingExternalImageProcessorProtocol {
        queue.sync(flags: .barrier) { [weak self] in
            guard let self else { return }
            _externalImageProcessors.removeAll { type(of: $0) == processorType }
        }
    }
}
