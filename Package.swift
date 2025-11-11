// swift-tools-version: 6.0

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
        .library(
            name: "SnappTheming",
            targets: ["SnappTheming"]
        ),
        .library(
            name: "SnappThemingSwiftUIHelpers",
            targets: ["SnappThemingSwiftUIHelpers"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Snapp-Mobile/SwiftFormatLintPlugin.git", exact: "1.0.4")
    ],
    targets: [
        .target(
            name: "SnappTheming",
            plugins: [
                .plugin(name: "Lint", package: "SwiftFormatLintPlugin")
            ]
        ),
        .testTarget(
            name: "SnappThemingTests",
            dependencies: ["SnappTheming"],
            resources: [
                .copy("Resources/fonts.json")
            ]
        ),
        .target(
            name: "SnappThemingSwiftUIHelpers",
            dependencies: ["SnappTheming"]
        ),
    ]
)
