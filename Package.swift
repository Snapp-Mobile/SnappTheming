// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnappTheming",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SnappTheming",
            targets: ["SnappTheming"]),
        .library(
            name: "SnappThemingSwiftUIHelpers",
            targets: ["SnappThemingSwiftUIHelpers"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SnappTheming",
            plugins: [
                .plugin(name: "SnappThemingSwiftFormatPlugin")
            ]),
        .testTarget(
            name: "SnappThemingTests",
            dependencies: ["SnappTheming"],
            resources: [
                .copy("Resources/fonts.json")
            ]
        ),
        .target(name: "SnappThemingSwiftUIHelpers"),
        .plugin(name: "SnappThemingSwiftFormatPlugin", capability: .buildTool(), path: "Plugins/SnappThemingSwiftFormatPlugin"),
    ]
)
