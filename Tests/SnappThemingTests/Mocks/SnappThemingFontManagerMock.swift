//
//  SnappThemingFontManagerMock.swift
//  SnappTheming
//
//  Created by Ilian Konchev on 15.01.25.
//

import Foundation
import SnappTheming

final class SnappThemingFontManagerMock: SnappThemingFontManager {
    var registeredFonts: Set<SnappThemingFontInformation> = []

    let queue = DispatchQueue(label: "SharedFontsCacheAccess")

    func registerFonts(_ fonts: [SnappThemingFontInformation]) {
        queue.sync {
            registeredFonts.formUnion(fonts)
        }
    }

    func unregisterFonts(_ fonts: [SnappThemingFontInformation]) {
        queue.sync {
            registeredFonts.subtract(fonts)
        }
    }

    func registerFont(_ font: SnappThemingFontInformation) {
        queue.sync {
            registeredFonts.insert(font)
        }
    }
}
