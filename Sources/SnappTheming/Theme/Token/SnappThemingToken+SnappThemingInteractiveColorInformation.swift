//
//  SnappThemingToken+SnappThemingInteractiveColorInformation.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 3.12.24.
//

extension SnappThemingToken where Value == SnappThemingInteractiveColorInformation {
    /// Initializes a `SnappThemingToken` with a `SnappThemingToken` of `SnappThemingColorRepresentation`.
    ///
    /// - If the provided token is an alias and its component is `"colors"`, the initializer wraps it into
    ///   a `SnappThemingInteractiveColorInformation` with the alias preserved.
    /// - Otherwise, it preserves the original alias or value appropriately.
    ///
    /// - Parameter token: The source token to initialize from, containing a `SnappThemingColorRepresentation`.
    public init(from token: SnappThemingToken<SnappThemingColorRepresentation>) {
        switch token {
        case .alias(let path):
            if path.component == "colors" {
                self = .value(Value(.alias(path)))
            } else {
                self = .alias(path)
            }
        case .value(let v):
            self = .value(Value(.value(v)))
        }
    }
}
