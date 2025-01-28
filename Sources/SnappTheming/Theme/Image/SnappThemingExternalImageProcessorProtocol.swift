//
//  SnappThemingExternalImageProcessorProtocol.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import UniformTypeIdentifiers
#if canImport(UIKit)
    import UIKit
#endif

/// A protocol defining a processor for custom image types, enabling conversion of `SnappThemingDataURI` to `UIImage`.
public protocol SnappThemingExternalImageProcessorProtocol: Sendable {
    #if canImport(UIKit)
        /// Processing image `Data` and `UIType` to convert into a `UIImage`.
        ///
        /// - Parameter data: Image `Data`.
        /// - Parameter type: Image `UTType`.
        /// - Returns: A `UIImage` if the conversion is successful; otherwise, `nil`.
        func process(_ data: Data, of type: UTType) -> UIImage?
    #endif
}
