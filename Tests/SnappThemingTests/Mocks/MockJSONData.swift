//
//  MockJSONData.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 24.01.2025.
//

import Foundation
import OSLog

class MockJSONData {
    static func font(_ name: String) -> String {
        guard let url = Bundle.module.url(forResource: "fonts", withExtension: "json") else {
            os_log(.debug, "Fonts JSON should be present")
            return ""
        }

        guard let jsonData = try? Data(contentsOf: url) else {
            os_log(.debug, "JSON should be readable")
            return ""
        }

        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
                let fonts = jsonObject["fonts"] as? [String: Any],
                let fontObject = fonts[name] as? [String: Any]
            {
                let fontData = try JSONSerialization.data(withJSONObject: fontObject)
                if let fontJSONString = String(data: fontData, encoding: .utf8) {
                    return fontJSONString
                } else {
                    os_log(.debug, "%@ not found", name)
                    return ""
                }
            } else {
                os_log(.debug, "%@ not found", name)
                return ""
            }
        } catch {
            os_log(.debug, "Failed to parse JSON: %@", error.localizedDescription)
            return ""
        }
    }
}
