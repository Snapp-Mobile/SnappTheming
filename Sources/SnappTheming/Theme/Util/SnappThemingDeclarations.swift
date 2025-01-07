//
//  SnappThemingDeclarations.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

import Foundation

@dynamicMemberLookup
public struct SnappThemingDeclarations<DeclaredValue, Configuration> where DeclaredValue: Codable {
    let rootKey: SnappThemingDeclaration.CodingKeys
    let resolver: SnappThemingTokenResolver<DeclaredValue>
    let configuration: Configuration

    public let keys: [String]
    public var cache: [String: SAThemingToken<DeclaredValue>] { resolver.baseValues[rootKey.rawValue] ?? [:] }

    init(cache: [String: SnappThemingToken<DeclaredValue>]?, rootKey: SnappThemingDeclaration.CodingKeys, configuration: Configuration) {
        self.rootKey = rootKey
        let cache = cache ?? [:]
        resolver = .init(baseValues: [rootKey.rawValue: cache])
        self.configuration = configuration
        keys = cache.compactMap {
            guard case .value = $0.value else { return nil }
            return $0.key
        }.sorted()
    }

    public subscript(dynamicMember keyPath: String) -> DeclaredValue? {
        let path = SnappThemingTokenPath(component: rootKey.rawValue, name: keyPath)
        return resolver.resolve(.alias(path))
    }
}

extension SnappThemingDeclarations where Configuration == Void {
    init(cache: [String: SnappThemingToken<DeclaredValue>]?, rootKey: SnappThemingDeclaration.CodingKeys) {
        self.init(cache: cache, rootKey: rootKey, configuration: ())
    }
}
