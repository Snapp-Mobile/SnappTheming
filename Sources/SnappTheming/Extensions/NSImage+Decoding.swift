//
//  NSImage+PDF.swift
//  SnappTheming
//
//  Created by Volodymyr Voiko on 04.12.2024.
//
#if canImport(AppKit)
    import AppKit
    import PDFKit
    import UniformTypeIdentifiers

    extension NSImage {
        static func pdf(data: Data) -> NSImage? {
            guard let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
            }

            let size = page.bounds(for: .mediaBox).size
            let image = NSImage(size: size)

            image.lockFocus()
            guard let context = NSGraphicsContext.current?.cgContext else {
                image.unlockFocus()
                return nil
            }

            context.saveGState()
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1, y: -1)

            page.draw(with: .mediaBox, to: context)

            context.restoreGState()
            image.unlockFocus()

            return image
        }
    }
#endif
