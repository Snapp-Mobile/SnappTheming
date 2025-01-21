//
//  SnappThemingImageConfiguration.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 20.01.2025.
//

import Foundation
import SwiftUI

/// Configuration for handling themed images in a SnappTheming framework.
public struct SnappThemingImageConfiguration {
    /// Fallback image to use when a specific image cannot be resolved.
    public let fallbackImage: Image

    /// Manager for handling image caching and retrieval.
    public let imagesManager: SnappThemingImageManager
}
