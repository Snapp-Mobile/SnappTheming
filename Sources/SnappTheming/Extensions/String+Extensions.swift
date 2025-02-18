//
//  String+Extensions.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 18.02.25.
//

extension String {
    func removingPrefix(separator: String) -> String {
        var components = self.split(separator: separator)
        components = Array(components.dropFirst())
        return components.joined(separator: separator)
    }
}
