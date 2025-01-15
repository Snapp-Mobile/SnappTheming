//
//  SnappThemingExternalImageConverterProtocol.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 15.01.2025.
//

import SnappTheming
import UIKit

/// A protocol defining a converter for custom image types, enabling conversion of `SnappThemingDataURI` to `UIImage`.
public protocol SnappThemingExternalImageConverterProtocol: Sendable {
    /// Converts a `SnappThemingDataURI` into a `UIImage`.
    ///
    /// - Parameter uri: The data URI containing the image data and its associated type.
    /// - Returns: A `UIImage` if the conversion is successful; otherwise, `nil`.
    func converte(_ uri: SnappThemingDataURI) -> UIImage?
}
