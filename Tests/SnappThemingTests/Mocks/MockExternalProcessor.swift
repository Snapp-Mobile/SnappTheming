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
    func process(_ object: SnappTheming.SnappThemingImageObject, of type: UTType) -> SnappThemingImage? {
        .system(name: "pencil")
    }
}
