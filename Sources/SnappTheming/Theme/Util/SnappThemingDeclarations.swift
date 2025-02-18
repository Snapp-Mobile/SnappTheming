//
//  SnappThemingDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

import Foundation
import OSLog

/// Generic structure for accessing theming declarations parsed from JSON files.
///
/// `SnappThemingDeclarations` acts as a dynamic gateway to various theming categories, such as colors, fonts, metrics, images, typography, and button styles etc..
/// By using `@dynamicMemberLookup`, it allows seamless access to declared values while providing robust fallback mechanisms.
///
/// ### Declaring Specific Theming Types
/// The following type aliases extend the base `SnappThemingDeclarations` for various UI components, making it easier to manage and resolve specific design tokens in a consistent and scalable way:
///
/// - ``SnappThemingColorDeclarations``:
///   Responsible for managing and resolving color tokens. This includes static colors and dynamic system colors, supporting light/dark mode.
///
/// - ``SnappThemingFontDeclarations``:
///   Manages font tokens, such as font families and sizes. Enables consistent typography across the app by centralizing font definitions.
///
/// - ``SnappThemingMetricDeclarations``:
///   Handles numeric tokens, such as spacing, corner radius, border widths. Useful for creating a consistent design language with reusable measurements.
///
/// - ``SnappThemingImageDeclarations``:
///   Manages image tokens. Supports bitmap assets for different scenarios.
///
/// - ``SnappThemingTypographyDeclarations``:
///   Manages typography tokens, combining font and size. Provides full control over how text styles are applied in the app.
///
/// - ``SnappThemingInteractiveColorDeclarations``:
///   Handles a set of colors representing interaction states, such as `normal`, `pressed`, and `disabled`. Useful for managing button states, toggle switches, and other interactive elements.
///
/// - ``SnappThemingButtonStyleDeclarations``:
///   Manages button style tokens, including properties like surface and text colors, border widths and color, shape and typography for various button states.
///
/// - ``SnappThemingShapeDeclarations``:
///   Manages shape tokens, defining the appearance of button outlines, such as circular, rounded rectangle, or custom shapes.
///
/// - ``SnappThemingGradientDeclarations``:
///   Manages shape style tokens, including support for gradients such as linear, radial, and angular, enabling the creation of dynamic and visually appealing shape backgrounds.
///
/// - ``SnappThemingSegmentControlStyleDeclarations``:
///   Manages segment control style tokens, enabling the customization of segment control appearance, including selected/unselected states, borders, shapes, and paddings.
///
/// - ``SnappThemingSliderStyleDeclarations``:
///   Handles slider style tokens, managing properties like track colors, tick mark styles for sliders used in the UI.
///
/// - ``SnappThemingToggleStyleDeclarations``:
///   Manages toggle style tokens, allowing control over the appearance of toggles, such as colors for enabled/disabled states.
@dynamicMemberLookup
public struct SnappThemingDeclarations<DeclaredValue, Configuration> where DeclaredValue: Codable {
    private let rootKey: SnappThemingDeclaration.CodingKeys

    /// The resolver used to resolve tokens into concrete representations of the declared values.
    /// Provides a mechanism to interpret and transform them based on the associated configuration.
    public let resolver: SnappThemingTokenResolver<DeclaredValue>

    /// The configuration object associated with the theming declarations.
    /// Contains fallback values and settings required to resolve tokens and define theming behavior.
    public let configuration: Configuration

    /// Keys available for theming declarations.
    /// These keys represent specific theming values in the cache that can be accessed dynamically.
    public let keys: [String]

    /// Cache containing resolved theming tokens.
    /// This cache stores the resolved values for easy retrieval, based on the root key and associated declared values.
    public var cache: [String: SnappThemingToken<DeclaredValue>] { resolver.baseValues[rootKey.rawValue] ?? [:] }

    /// Initializes a `SnappThemingDeclarations` instance.
    /// - Parameters:
    ///   - cache: Optional cache of theming tokens, which may be nil. If not provided, an empty cache will be used.
    ///   - rootKey: The root key under which values are resolved in the theming configuration.
    ///   - configuration: The configuration object associated with the theming declarations, providing fallback values and other settings.
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        rootKey: SnappThemingDeclaration.CodingKeys,
        configuration: Configuration
    ) {
        self.rootKey = rootKey

        // Use an empty dictionary if no cache is provided
        let cache = cache ?? [:]

        // Initialize the resolver with the cache and root key
        self.resolver = SnappThemingTokenResolver(baseValues: [rootKey.rawValue: cache])
        self.configuration = configuration

        // Extract valid keys (those with value tokens)
        self.keys = cache.compactMap {
            guard case .value = $0.value else { return nil }
            return $0.key
        }.sorted()
    }

    /// Resolves a declared value dynamically based on a key path
    /// - Parameter keyPath: The key path to resolve the value.
    /// - Returns: The resolved `DeclaredValue` if found, or `nil` if unavailable.
    public subscript(dynamicMember keyPath: String) -> DeclaredValue? {
        // Validate the input key path
        guard !keyPath.isEmpty else {
            os_log(.debug, "Invalid access to keyPath '%@': Key path is empty", keyPath)
            runtimeWarning(#file, #line, "Invalid access to keyPath '\(rootKey.rawValue)'.'\(keyPath)': Key path is empty.")
            return nil
        }

        // Build the token path
        let tokenPath = SnappThemingTokenPath(component: rootKey.rawValue, name: keyPath)

        // Resolve the value using the resolver
        do {
            return try resolver.resolveThrowing(.alias(tokenPath))
        } catch {
            runtimeWarning(#file, #line, "Failed to resolve the value: \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK: - Convenience Initializer for Void Configuration
extension SnappThemingDeclarations where Configuration == Void {
    /// Initializes a `SnappThemingDeclarations` instance with a void configuration.
    /// - Parameters:
    ///   - cache: Optional cache of theming tokens, which may be nil. If not provided, an empty cache will be used.
    ///   - rootKey: The root key under which values are resolved in the theming configuration.
    public init(
        cache: [String: SnappThemingToken<DeclaredValue>]?,
        rootKey: SnappThemingDeclaration.CodingKeys
    ) {
        self.init(cache: cache, rootKey: rootKey, configuration: ())
    }
}
