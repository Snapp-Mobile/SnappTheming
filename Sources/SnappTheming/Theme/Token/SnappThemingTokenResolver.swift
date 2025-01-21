//
//  SnappThemingTokenResolver.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

/// A utility for resolving tokens to their associated values.
///
/// The `TokenResolver` works with tokens that can either directly hold a value
/// (`.value`) or point to another token using an alias (`.alias`). When resolving
/// a token, the resolver ensures no infinite loops occur by keeping track of
/// already visited paths during the resolution process.
///
/// - Note: This resolver assumes the `Value` type conforms to `Codable`.
///
/// - Generic Parameter:
///   - Value: The type of value being resolved.
public struct SnappThemingTokenResolver<Value> where Value: Codable {
    /// A dictionary holding the base tokens, organized by component and name.
    let baseValues: [String: [String: SnappThemingToken<Value>]]

    /// Resolves a `Token` to its associated `Value`.
    ///
    /// This function initiates the resolution process without any prior visited paths.
    ///
    /// - Parameter token: The `Token` to resolve.
    /// - Returns: The resolved `Value`, or `nil` if the token cannot be resolved.
    func resolve(_ token: SnappThemingToken<Value>) -> Value? {
        resolve(token, from: [])
    }

    /// Recursively resolves a `Token` to its associated `Value`.
    ///
    /// This function takes a `Token` and attempts to resolve it to its actual value.
    /// A `Token` can either directly hold a value (`.value`) or be an alias pointing
    /// to another path. If the token is an alias, the function recursively resolves
    /// it by following the path, ensuring no infinite loops by keeping track of visited paths.
    ///
    /// - Parameters:
    ///   - token: The `Token` to resolve. It can be a direct value or an alias.
    ///   - visitedPaths: A list of paths that have already been visited during resolution.
    ///                   Used to prevent infinite recursion caused by circular references.
    /// - Returns: The resolved `Value` if it can be found, or `nil` if the token cannot be resolved.
    private func resolve(_ token: SnappThemingToken<Value>, from visitedPaths: [SnappThemingTokenPath]) -> Value? {
        switch token {
        case let .value(value):
            // If the token directly holds a value, return it.
            return value
        case let .alias(path) where !visitedPaths.contains(path):
            // If the token is an alias and the path has not been visited:
            // 1. Look up the alias in the baseValues dictionary.
            // 2. If found, recursively resolve the alias, adding the current path to visitedPaths.
            guard let resolvedToken = baseValues[path.component]?[path.name] else {
                return nil
            }
            return resolve(resolvedToken, from: visitedPaths + [path])
        case .alias:
            // If the alias has already been visited (to avoid infinite recursion), return nil.
            return nil
        }
    }
}
