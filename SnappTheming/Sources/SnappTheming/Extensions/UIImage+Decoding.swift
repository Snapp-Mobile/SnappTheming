//
//  UIImage+PDF.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 04.12.2024.
//


import UIKit
import PDFKit
import UniformTypeIdentifiers

class SVGImageConverter {
    let uiImage: UIImage = .checkmark

    init(data: Data) { }
}

extension UIImage {
    static func fromDataURIWithSVGSupport(dataURI: SnappThemingDataURI) -> UIImage? {
        fromDataWithSVGSupport(data: dataURI.data, of: dataURI.type)
    }

    static func fromDataWithSVGSupport(data: Data, of type: UTType) -> UIImage? {
        switch type {
        case .svg: SVGImageConverter(data: data).uiImage
        default: from(data, of: type)
        }
    }
    static func from(_ dataURI: SnappThemingDataURI) -> UIImage? {
        from(dataURI.data, of: dataURI.type)
    }

    static func from(_ data: Data, of type: UTType) -> UIImage? {
        switch type {
        case .pdf: .pdf(data: data)
        case .png, .jpeg: .init(data: data)
        default: nil
        }
    }

    static func pdf(data: Data) -> UIImage? {
        guard let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
        }
        let size = page.bounds(for: .mediaBox).size
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.saveGState()
            cgContext.translateBy(x: 0, y: size.height)
            cgContext.scaleBy(x: 1, y: -1)
            
            page.draw(with: .mediaBox, to: cgContext)

            cgContext.restoreGState()
        }
        .withRenderingMode(.alwaysTemplate)
    }
}
protocol ImageConverterProtocol {
    func pdf(data: Data) -> UIImage?
}
public class ImageConverter {
    func pdf(data: Data) -> UIImage? {
        guard let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
        }
        let size = page.bounds(for: .mediaBox).size
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            let cgContext = context.cgContext
            cgContext.saveGState()
            cgContext.translateBy(x: 0, y: size.height)
            cgContext.scaleBy(x: 1, y: -1)

            page.draw(with: .mediaBox, to: cgContext)

            cgContext.restoreGState()
        }
        .withRenderingMode(.alwaysTemplate)
    }
}
