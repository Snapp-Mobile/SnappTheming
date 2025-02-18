//
//  RuntimeWarning.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 17.02.2025.
//
// swift-format-ignore-file
import Foundation
import OSLog

#if DEBUG
/// Checks if the code is running within a test environment.
///
/// This function inspects the process environment to determine whether
/// unit tests are currently executing. If the `XCTestConfigurationFilePath`
/// environment variable is present, it indicates that tests are running.
///
/// - Returns: `true` if running within a test environment, otherwise `false`.
private func runningTests() -> Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
}
#endif

/// Logs a runtime warning in debug mode, avoiding logs during unit tests.
///
/// This function helps to identify potential issues by logging warnings
/// at runtime while ensuring test environments remain clean. It utilizes `os_log`
/// to provide unobtrusive warnings in debug builds, and prevents unnecessary logs
/// from appearing in test runs.
///
/// - Parameter message: The warning message to log.
///
/// The idea is taken from [pointfree.co](https://www.pointfree.co/blog/posts/70-unobtrusive-runtime-warnings-for-libraries)
internal func runtimeWarning(
    _ message: String
) {
    if !runningTests() { // Avoid logging during unit tests
        #if DEBUG
            var info = Dl_info()
            dladdr(dlsym(dlopen(nil, RTLD_LAZY), "$s10Foundation15AttributeScopesO7SwiftUIE05swiftE0AcDE0D12UIAttributesVmvg"), &info)
            // View more about the source file in the Issue Navigator (⌘5).
            os_log(.fault, dso: info.dli_fbase, log: OSLog(subsystem: "com.apple.runtime-issues", category: "SnappTheming"), "%@",message)
        #else
            os_log(.debug, "%{public}@", message)
        #endif
    } else {
        // Ensure test logs remain minimal and non-intrusive.
        os_log(.debug, "%{public}@", message)
    }
}
