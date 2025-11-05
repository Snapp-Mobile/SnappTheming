//
//  SnappThemingExternalImageProcessorProtocol.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import SwiftUI
import UniformTypeIdentifiers

/// A protocol defining a processor for custom image types, enabling conversion of ``SnappThemingDataURI`` to ``SnappThemingImage`` .
public protocol SnappThemingExternalImageProcessorProtocol: Sendable {
    /// Processing image `Data` and `UIType` to convert into a ``SnappThemingImage``.
    ///
    /// - Parameter object: Image object of `SnappThemingImageObject` type - contains raw data and url if available.
    /// - Parameter type: Image `UTType`.
    /// - Returns: A `SnappThemingImage` if the conversion is successful; otherwise, `nil`.
    func process(_ object: SnappThemingImageObject, of type: UTType) -> SnappThemingImage?
}
