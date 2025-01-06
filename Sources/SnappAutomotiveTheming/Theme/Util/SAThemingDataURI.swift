//
//  SAThemingDataURI.swift
//  SnappAutomotiveTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation
import UniformTypeIdentifiers

public struct SAThemingDataURI: Codable {
    public enum Encoding: String {
        case base64
    }

    private enum DecodingError: Error {
        case invalidFormat
        case invalidData
        case invalidType
        case unsupportedEncoding
    }

    private enum EncodingError: Error {
        case missingMIMEType
    }

    public let type: UTType
    public let encoding: Encoding
    public let data: Data

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let source = try container.decode(String.self)

        let sourceComponents = source.split(separator: ",")

        guard sourceComponents.count == 2 else {
            throw DecodingError.invalidFormat
        }

        let metadataComponent = sourceComponents[0]
        let dataComponent = sourceComponents[1]

        let metadataComponents = metadataComponent.split(separator: ";")

        guard
            metadataComponents.count == 2,
            let mimeType = metadataComponents[0].split(separator: ":").last.map(String.init)
        else {
            throw DecodingError.invalidFormat
        }

        guard let type = UTType(mimeType: mimeType) else {
            throw DecodingError.invalidType
        }

        guard let encoding = Encoding.init(rawValue: String(metadataComponents[1])) ?? nil else {
            throw DecodingError.unsupportedEncoding
        }

        guard
            let base64EncodedData = dataComponent.data(using: .utf8),
            let data = Data(base64Encoded: base64EncodedData)
        else {
            throw DecodingError.invalidData
        }

        self.type = type
        self.encoding = encoding
        self.data = data
    }

    public func encode(to encoder: any Encoder) throws {
        guard let mimeType = type.preferredMIMEType else {
            throw EncodingError.missingMIMEType
        }
        try "data:\(mimeType);\(encoding.rawValue),\(data.base64EncodedString())".encode(to: encoder)
    }
}
