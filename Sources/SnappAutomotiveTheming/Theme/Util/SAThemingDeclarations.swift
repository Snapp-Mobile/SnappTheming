//
//  SADeclarations.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 28.11.2024.
//

import Foundation

@dynamicMemberLookup
public struct SAThemingDeclarations<DeclaredValue, Configuration> where DeclaredValue: Codable {
    let rootKey: SAThemingDeclaration.CodingKeys
    let resolver: SAThemingTokenResolver<DeclaredValue>
    let configuration: Configuration

    public let keys: [String]

    init(cache: [String: SAThemingToken<DeclaredValue>]?, rootKey: SAThemingDeclaration.CodingKeys, configuration: Configuration) {
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
        let path = SAThemingTokenPath(component: rootKey.rawValue, name: keyPath)
        return resolver.resolve(.alias(path))
    }
}

extension SAThemingDeclarations where Configuration == Void {
    init(cache: [String: SAThemingToken<DeclaredValue>]?, rootKey: SAThemingDeclaration.CodingKeys) {
        self.init(cache: cache, rootKey: rootKey, configuration: ())
    }
}
