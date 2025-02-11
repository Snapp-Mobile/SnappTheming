//
//  Error+Extensions.swift
//  SnappTheming
//
//  Created by Oleksii Kolomiiets on 01.12.2024.
//

import Foundation
import OSLog

extension Error {
    func log() {
        let logger = Logger(subsystem: "SnappAutomotiveTheming", category: "DecodingError")

        if let decodingError = self as? DecodingError {
            switch decodingError {
            case .dataCorrupted(let context):
                logger.error("Data corrupted: \(context.debugDescription, privacy: .public)")
                if let underlyingError = context.underlyingError {
                    logger.error("Underlying error: \(underlyingError.localizedDescription, privacy: .public)")
                }

            case .keyNotFound(let key, let context):
                logger.error(
                    "Key not found: \(key.stringValue, privacy: .public) in \(context.codingPath.map(\.stringValue).joined(separator: " -> "), privacy: .public)"
                )
                logger.error("Debug description: \(context.debugDescription, privacy: .public)")

            case .typeMismatch(let type, let context):
                logger.error(
                    "Type mismatch for type \(String(describing: type), privacy: .public) at \(context.codingPath.map(\.stringValue).joined(separator: " -> "), privacy: .public)"
                )
                logger.error("Debug description: \(context.debugDescription, privacy: .public)")

            case .valueNotFound(let value, let context):
                logger.error(
                    "Value \(String(describing: value), privacy: .public) not found at \(context.codingPath.map(\.stringValue).joined(separator: " -> "), privacy: .public)"
                )
                logger.error("Debug description: \(context.debugDescription, privacy: .public)")
            @unknown default:
                logger.error("Unknown decoding error: \(localizedDescription, privacy: .public)")
            }
        } else {
            logger.error("Unknown decoding error: \(localizedDescription, privacy: .public)")
        }
    }
}
