//
//  Theme.swift
//  Example
//
//  Created by Volodymyr Voiko on 03.02.2025.
//

import Foundation
import SnappTheming

@Observable
@dynamicMemberLookup
final class Theme {
    private static let themeSourceFileNameKey = "theme_filename"

    var declaration: SnappThemingDeclaration {
        if let declaration = _declaration {
            return declaration
        }

        let declaration = source.loadDeclaration()
        _declaration = declaration
        return declaration
    }

    private var _declaration: SnappThemingDeclaration?

    private(set) var source: ThemeSource = .light {
        didSet {
            guard oldValue != source else { return }
            UserDefaults.standard.set(
                source.filename,
                forKey: Self.themeSourceFileNameKey)
            _declaration = nil
        }
    }

    init(_ source: ThemeSource) {
        self.source = source
    }

    convenience init() {
        let source = UserDefaults.standard.string(
            forKey: Self.themeSourceFileNameKey
        )
        .map(ThemeSource.init(rawValue:))
        self.init(source ?? .default)
    }

    func change(_ source: ThemeSource) {
        self.source = source
        _declaration = nil
    }

    subscript<Value>(
        dynamicMember keyPath: KeyPath<SnappThemingDeclaration, Value>
    ) -> Value {
        declaration[keyPath: keyPath]
    }
}

extension ThemeSource {
    fileprivate func loadDeclaration() -> SnappThemingDeclaration {
        .load(filename: filename)
    }
}
