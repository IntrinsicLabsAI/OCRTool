//
//  App.swift
//  OCRTool
//
//  Created by Andrew Duffy on 5/17/23.
//

import EndpointSecurity
import Foundation
import VisionKit
import PDFKit
import CoreGraphics

@main
struct App {
    
    static func extractPdf(filePath: URL) async {
        let analyzer = ImageAnalyzer()
        guard let document = PDFDocument(url: filePath) else {
            fatalError("Failed to load PDF at path \(filePath)")
        }

        for pageNum in (0..<document.pageCount) {
            let page = document.page(at: pageNum)!
            // Create one using the aspect ratios
            guard let ctx = CGContext(
                                data: nil,
                                width: 850,
                                height: 1100,
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * 850,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) else {
                fatalError("Failed to create a gfx context")
            }
            page.draw(with: .mediaBox, to: ctx)
            guard let img = ctx.makeImage() else {
                fatalError("Could not makeImage")
            }

            let analysis = try! await analyzer.analyze(img, orientation: .up, configuration: .init(.text))
            print(analysis.transcript)
        }
    }
    
    static func extractImage(filePath: URL) async {
        let analyzer = ImageAnalyzer()
        let img = NSImage(byReferencing: filePath)
        let analysis = try! await analyzer.analyze(img, orientation: .up, configuration: .init(.text))
        print(analysis.transcript)
    }

    static func main() async {
        for file in CommandLine.arguments.dropFirst(1) {
            if file.hasSuffix(".pdf") {
                await extractPdf(filePath: URL(filePath: file))
            } else {
                await extractImage(filePath: URL(filePath: file))
            }
        }
    }
}
