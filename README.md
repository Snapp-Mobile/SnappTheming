# SnappTheming

![Static Badge](https://img.shields.io/badge/swift--tools--version-6.0-blue) ![Static Badge](https://img.shields.io/badge/Platforms-_iOS_|_macOS_|_tvOS_|_watchOS_|_visionOS_-blue) 


<p align="center">
    <img src="Sources/SnappTheming/SnappTheming.docc/Resources/logo%402x.png">
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

#### Prepare JSON with declarations

To initiate the process, it would suffice to have a declaration made in a JSON file or simply as a string.
```swift
private let json = """
    {
        "colors": {
            "textPrimary": "#000",
        },
        "fonts": {
            "Doto-Regular": {
                "postScriptName": "Doto-Regular",
                "source": "data:font/ttf;base64,AAEAAA*******EBMgEA"
            }
        },
        "typography": {
            "title": {
                "font": "$fonts/Doto-Regular",
                "fontSize": 16
            },
        }
    }
    """
```
Initiate the declaration as follows:

```swift
extension SnappThemingDeclaration {
    static let light: SnappThemingDeclaration = {
        let configuration = SnappThemingParserConfiguration(themeName: "Light")
        let declaration = try! SnappThemingParser.parse(from: json, using: configuration)
        let fontManager = SnappThemingFontManagerDefault(
            themeCacheRootURL: configuration.themeCacheRootURL,
            themeName: configuration.themeName
        )
        fontManager.registerFonts(declaration.fontInformation)
        return declaration
    }()
}
```

With this capability, you can now seamlessly integrate it into your robust application, enabling users to access it effortlessly.

```swift
import SnappTheming
import SwiftUI

@main
struct HelloWorldApp: App {
    let declaration: SnappThemingDeclaration = .light

    var body: some Scene {
        WindowGroup {
            Text("Hello World!")
                .foregroundStyle(declaration.colors.textPrimary)
                .font(declaration.typography.title)
        }
    }
}
```




