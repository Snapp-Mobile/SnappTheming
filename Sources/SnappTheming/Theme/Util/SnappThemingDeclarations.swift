//
//  SnappThemingDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

import Foundation

/// Generic structure for accessing theming declarations parsed from JSON files.
///
/// `SnappThemingDeclarations` acts as a dynamic gateway to various theming categories, such as colors, fonts, metrics, images, typography, and button styles etc..
/// By using `@dynamicMemberLookup`, it allows seamless access to declared values while providing robust fallback mechanisms.
///
/// ### Declaring Specific Theming Types
/// The following type aliases extend the base `SnappThemingDeclarations` for various UI components:
/// - ``SnappThemingColorDeclarations``: Manages color tokens.
/// - ``SnappThemingFontDeclarations``: Manages font tokens.
/// - ``SnappThemingMetricDeclarations``: Manages numeric tokens.
/// - ``SnappThemingImageDeclarations``: Manages image tokens.
/// - ``SnappThemingTypographyDeclarations``: Manages typography tokens.
/// - ``SnappThemingButtonStyleDeclarations``: Manages button style tokens.
/// - ``SnappThemingInteractiveColorDeclarations``: Manages a set of colors representing various interaction states, such as `normal, selected, pressed, and disabled`.
/// - ``SnappThemingButtonStyleShapeDeclarations``: Manages shape tokens.
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
            print("Invalid access to keyPath '\(keyPath)': Key path is empty")
            return nil
        }

        // Build the token path
        let path = SnappThemingTokenPath(component: rootKey.rawValue, name: keyPath)

        // Resolve the value using the resolver
        guard let resolvedValue = resolver.resolve(.alias(path)) else {
            print("Invalid access to keyPath '\(keyPath)': Failed to resolve the value")
            return nil
        }

        return resolvedValue
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
