//
//  SnappThemingToken+InteractiveColorInformation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

extension SnappThemingToken where Value == SnappThemingInteractiveColorInformation {
    public init(from token: SnappThemingToken<SnappThemingColorRepresentation>) {
        switch token {
        case .alias(let path):
            if path.component == "colors" {
                self = .value(.init(.alias(path)))
            } else {
                self = .alias(path)
            }
        case .value(let v):
            self = .value(.init(.value(v)))
        }
    }
}
