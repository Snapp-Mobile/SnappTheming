//
//  SwiftLintPlugin.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 21.01.2025.
//

import Foundation
import PackagePlugin

/// A Swift Package Manager build tool plugin to run SwiftFormat during the build process.
@main
struct SwiftFormatPlugin: BuildToolPlugin {
    /// Creates build commands for the plugin.
    /// - Parameters:
    ///   - context: The plugin context providing details like the package directory.
    ///   - target: The target on which the plugin is applied.
    /// - Returns: An array of build commands to execute during the build process.
    /// - Throws: `PluginError` if the script is not found.
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        // Define the path to your script
        let scriptPath = context.package.directoryURL.appending(path: "Plugins/SwiftFormatPlugin/swift-format-script.sh").path
        let configurationPath = context.package.directoryURL.absoluteString

        // Validate that the script exists
        guard FileManager.default.fileExists(atPath: scriptPath) else {
            throw PluginError.scriptNotFound("Script not found at \(scriptPath)")
        }

        // Return a build command to run your script
        return [
            .buildCommand(
                displayName: "Running SwiftFormatPlugin",
                executable: URL(filePath: "/bin/bash"),
                arguments: [scriptPath, configurationPath],
                environment: [:],
                inputFiles: [],
                outputFiles: []
            )
        ]
    }
}

/// Custom errors for the plugin.
enum PluginError: Error, CustomStringConvertible {
    /// Thrown when the script file is not found.
    case scriptNotFound(String)

    /// A description of the error.
    var description: String {
        switch self {
        case .scriptNotFound(let message):
            return message
        }
    }
}
