//
//  ExampleApp.swift
//  Example
//
//  Created by Ilian Konchev on 21.11.24.
//

import OSLog
import SnappTheming
import SwiftUI

#if !os(visionOS)
    import SnappThemingSVGSupport
#endif

@main
struct ExampleApp: App {
    init() {
        #if !os(visionOS)
            // Do this for turning the SVG processor on
            SnappThemingImageProcessorsRegistry.shared.register(.svg)
        #endif
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .themed()
        }
    }
}
