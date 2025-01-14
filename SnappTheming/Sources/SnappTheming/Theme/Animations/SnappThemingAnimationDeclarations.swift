//
//  SnappThemingAnimationDeclarations.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 14.01.2025.
//

import Foundation
import OSLog

/// A type alias for theming animation declarations, mapping animations to their representations and configurations.
public typealias SnappThemingAnimationDeclarations = SnappThemingDeclarations<SnappThemingAnimationRepresentation, SnappThemingAnimationConfiguration>

/// Configuration for theming animations.
///
/// This struct holds fallback data for Lottie animations in case no specific animation is provided.
public struct SnappThemingAnimationConfiguration {
    /// The fallback Lottie animation data used when no valid animation is available.
    public let fallbackLottieAnimationData: Data
}

extension SnappThemingAnimationDeclarations where DeclaredValue == SnappThemingAnimationRepresentation, Configuration == SnappThemingAnimationConfiguration {
    /// Initializes animation declarations with caching and configuration options.
    ///
    /// - Parameters:
    ///   - cache: A dictionary of cached theming tokens for declared animation values.
    ///   - configuration: The configuration for the parser, including fallback animation data.
    public init(cache: [String: SnappThemingToken<DeclaredValue>]?, configuration: SnappThemingParserConfiguration = .default) {
        self.init(
            cache: cache,
            rootKey: .animations,
            configuration: .init(
                fallbackLottieAnimationData: configuration.fallbackLottieAnimationData
            )
        )
    }

    /// Accesses the animation value dynamically by a key path.
    ///
    /// - Parameter keyPath: The key path string identifying the desired animation.
    /// - Returns: The declared animation value if available, or the fallback animation value.
    public subscript(dynamicMember keyPath: String) -> DeclaredValue.SnappThemingAnimationValue {
        if let representation: DeclaredValue = self[dynamicMember: keyPath] {
            return representation.animation
        } else {
            os_log(.debug, "Warning: Missing animation for key path '%@'. Using fallback animation.", keyPath)
            return .lottie(configuration.fallbackLottieAnimationData)
        }
    }
}
