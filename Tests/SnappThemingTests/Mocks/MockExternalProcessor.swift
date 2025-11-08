//
//  MockExternalProcessor.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 11/8/25.
//

import Foundation
import SnappTheming
import UniformTypeIdentifiers

final class MockExternalProcessor: SnappThemingExternalImageProcessorProtocol {
    let dummyImage = SnappThemingImage(systemSymbolName: "pencil", accessibilityDescription: "test")
    func process(_ object: SnappTheming.SnappThemingImageObject, of type: UTType) -> SnappThemingImage? {
        dummyImage
    }
}
