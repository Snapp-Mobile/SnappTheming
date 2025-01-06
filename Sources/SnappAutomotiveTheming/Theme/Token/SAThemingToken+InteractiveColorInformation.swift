//
//  SAThemingToken+InteractiveColorInformation.swift
//  SnappAutomotiveTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

extension SAThemingToken where Value == SAThemingInteractiveColorInformation {
    public init(from token: SAThemingToken<SAThemingColorRepresentation>) {
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
