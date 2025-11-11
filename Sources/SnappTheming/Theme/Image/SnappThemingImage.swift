//
//  SnappThemingImage.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 24.02.2025.
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

/// A cross-platform type alias for images in SnappTheming.
///
/// - On **iOS, iPadOS, tvOS, watchOS**, and **visionOS**, `SnappThemingImage` is an alias for `UIImage`.
/// - On **macOS**, `SnappThemingImage` is an alias for `NSImage`.
///
/// This ensures compatibility across different Apple platforms without the need for conditional compilation
/// in the rest of the codebase.
#if canImport(UIKit)
    /// Represents an image type on iOS, iPadOS, tvOS, watchOS, and visionOS.
    public typealias SnappThemingImage = UIImage
#elseif canImport(AppKit)
    /// Represents an image type on macOS.
    public typealias SnappThemingImage = NSImage
#endif
