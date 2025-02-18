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
private func runningTests() -> Bool { ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil }
#endif

internal func runtimeWarning(
    _ file: String,
    _ line: Int,
    _ message: String
) {
    let fileName = file.split(separator: "/").last.map(String.init) ?? file
    if !runningTests() {
        #if DEBUG
            var info = Dl_info()
            dladdr(dlsym(dlopen(nil, RTLD_LAZY), "$s10Foundation15AttributeScopesO7SwiftUIE05swiftE0AcDE0D12UIAttributesVmvg"), &info)
            // View more about the source file in the Issue Navigator (⌘5).
            os_log(.fault, dso: info.dli_fbase, log: OSLog(subsystem: "com.apple.runtime-issues", category: "SnappTheming"), "[%@:%d]: %@", fileName, line, message)
        #else
            os_log(.debug, "%{public}@:%{public}d]: %{public}@", fileName, line, message)
        #endif
    } else {
        os_log(.debug, "%{public}@:%{public}d]: %{public}@", fileName, line, message)
    }
}
