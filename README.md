# SnappTheming

<p align="center">
    <br />
    <img src="Sources/SnappTheming/SnappTheming.docc/Resources/logo%402x.png">
    <br /><br />
    <a href="https://img.shields.io/badge/version-0.1.1-yellow" target="_blank"><img src="https://img.shields.io/badge/version-0.1.1-yellow" alt="Version 0.1.1"></a>
    <a href="https://img.shields.io/badge/swift--tools--version-6.0-red" target="_blank"><img src="https://img.shields.io/badge/swift--tools--version-6.0-red" alt="Swift Tools Version 6.0"></a>
    <a href="https://github.com/Snapp-Mobile/SnappTheming/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue" alt="License Badge"></a>
    <br />
    <a href="https://img.shields.io/badge/Platforms-_iOS_|_macOS_|_tvOS_|_watchOS_|_visionOS_-green" target="_blank"><img src="https://img.shields.io/badge/Platforms-_iOS_|_macOS_|_tvOS_|_watchOS_|_visionOS_-green" alt="Supported Platforms"></a>
<p/>

`SnappTheming` is a Swift framework designed to streamline the process of integrating dynamic design themes into iOS applications. 

By leveraging JSON declarations, the framework allows developers to easily extract and apply various theming elements such as colors, fonts, gradients, and shape styles, directly into their app’s user interface.

## Contents

This repository contains the `SnappTheming` framework as well as an Example Xcode project to demonstrate its capabilities.

## Documentation

The documentation for the package can be found [here](https://ios-theming.snappmobile.io/documentation/snapptheming/)

## Tutorial

Explore the essentials of creating your first theme with SnappTheming in SwiftUI, defining colors and styles, and managing multiple themes for seamless user switching. Follow the tutorials for hands-on experience in theming your projects effectively. It can be found [here](https://ios-theming.snappmobile.io/tutorials/meetsnapptheming/)

## Quick Start

### Instalation

#### Using Xcode
1. Navigate to your project settings.
2. Select the “Package Dependencies” option.
3. Utilize the search feature to locate the repository: `https://github.com/Snapp-Mobile/SnappTheming`.
4. Choose the “SnappTheming” package and select “Add Package” to incorporate it into your project.

#### Using Swift Package Manager
```swift
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .package(url: "https://github.com/Snapp-Mobile/SnappTheming", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "YourPackage",
            dependencies: ["SnappTheming"]
        )
    ]
)
```

### Usage

#### In a SwiftUI App

```swift
import OSLog
import SnappTheming
import SwiftUI

@main
struct STTestApp: App {
    @State var declaration: SnappThemingDeclaration?

    // Discover more about the JSON Schema at 
    // https://ios-theming.snappmobile.io/documentation/snapptheming/jsonschema
    private let json = """
        {
            "colors": {
                "textPrimary": "#1a1a1a",
            },
            "images": {
                "globe": "system:globe"
            },
            "metrics": {
                "label": 16.0,
                "icon": 24
            },
            "fonts": {
                "label": {
                    "postScriptName": "Arial-BoldMT"
                }
            },
            "typography": {
                "title": {
                    "font": "$fonts/label",
                    "fontSize": "$metrics/label"
                }
            }
        }
        """

    init() {
        let configuration = SnappThemingParserConfiguration(themeName: "Light")
        guard let declaration = try? SnappThemingParser.parse(from: json, using: configuration) else {
            os_log(.error, "Error loading theme")
            return
        }

        if !declaration.fontInformation.isEmpty {
            let fontManager = SnappThemingFontManagerDefault(
                themeCacheRootURL: configuration.themeCacheRootURL,
                themeName: configuration.themeName
            )
            fontManager.registerFonts(declaration.fontInformation)
        }
        _declaration = .init(initialValue: declaration)
    }

    var body: some Scene {
        WindowGroup {
            if let declaration {
                VStack {
                    HStack(alignment: .center) {
                        declaration.images.globe
                            .resizable()
                            .frame(maxWidth: declaration.metrics.icon, maxHeight: declaration.metrics.icon)

                        Text("Praise Kier.")
                            .font(declaration.typography.title)
                    }
                }
                .foregroundStyle(declaration.colors.textPrimary)
            } else {
                Text("Unable to load the theme")
                    .bold()
            }
        }
    }
}
```
## License

[MIT License](https://github.com/Snapp-Mobile/SnappTheming/blob/main/LICENSE)
