//
//  RuntimeWarning.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 17.02.2025.
//

import Foundation
import OSLog

#if DEBUG
    private func runningTests() -> Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil
    }
#endif

internal func runtimeWarning(_ message: String) {
    #if DEBUG
        if runningTests() {
            var info = Dl_info()
            dladdr(
                dlsym(
                    dlopen(nil, RTLD_LAZY),
                    """
                    $s10Foundation15AttributeScopesO7SwiftUIE05swiftE0AcDE0D12UIAttributesVmvg
                    """
                ),
                &info
            )
            // Find the warning in the Issue Navigator (⌘5) to view the full stack trace captured at the moment the warning was logged.
            // Selecting element number '1' in the stack trace will take you to the exact location where the warning was triggered.
            os_log(
                .fault,
                dso: info.dli_fbase,
                log: OSLog(
                    subsystem: "com.apple.runtime-issues",
                    category: "SnappTheming"
                ),
                "%@", message
            )
        } else {
            os_log(.debug, "%@", message)
        }
    #else
        os_log(.debug, "%@", message)
    #endif
}
