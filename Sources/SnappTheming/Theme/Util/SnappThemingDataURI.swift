//
//  SnappThemingDataURI.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 29.11.2024.
//

import Foundation
import UniformTypeIdentifiers

/// Represents a data URI, which includes the data's type, encoding, and the data itself.
public struct SnappThemingDataURI: Sendable, Hashable {
    /// The encoding type used in the data URI.
    public enum Encoding: String, Sendable {
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

    /// The type of the data, represented as a `UTType`.
    public let type: UTType

    /// The encoding used for the data.
    public let encoding: Encoding

    /// The raw data represented by the data URI.
    public let data: Data
}

extension SnappThemingDataURI: Codable {
    /// Initializes a new instance by decoding a data URI from the provided decoder.
    ///
    /// The expected format is: `data:[<MIME-type>][;base64],<data>`.
    ///
    /// - Parameter decoder: The decoder to read the data URI from.
    /// - Throws: An error if the data URI is malformed or invalid.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let source = try container.decode(String.self)

        try self.init(from: source)
    }

    public init(from source: String) throws {
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

    /// Encodes this data URI into the provided encoder.
    ///
    /// The format will be: `data:[<MIME-type>][;base64],<data>`.
    ///
    /// - Parameter encoder: The encoder to write the data URI to.
    /// - Throws: An error if the MIME type is missing or encoding fails.
    public func encode(to encoder: any Encoder) throws {
        guard let mimeType = type.preferredMIMEType else {
            throw EncodingError.missingMIMEType
        }

        let dataURI = "data:\(mimeType);\(encoding.rawValue),\(data.base64EncodedString())"
        try dataURI.encode(to: encoder)
    }
}
