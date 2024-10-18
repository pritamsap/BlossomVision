//
//  CMSampleBuffer.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-14.
//

import Foundation
import AVFoundation
import CoreImage
import CoreML

/*
 Convert Buffer to CGImage
 */
extension CMSampleBuffer {
    var cgImage: CGImage? {
        let pixelBuffer: CVPixelBuffer? = CMSampleBufferGetImageBuffer(self)
        
        guard let imagePixelBuffer = pixelBuffer else {
            return nil
        }
        
        return CIImage(cvPixelBuffer: imagePixelBuffer).cgImage
    }
}


extension CIImage {
    
    var cgImage: CGImage? {
        let ciContext = CIContext()
            
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else {
                return nil
        }
        
        return cgImage
            
    }
}


// Core video pixel buffers
extension CGImage {
    
    func toPixelBuffer(size: CGSize) -> CVPixelBuffer? {
            let width = Int(size.width)
            let height = Int(size.height)

            var pixelBuffer: CVPixelBuffer?

            let attributes: [CFString: Any] = [
                kCVPixelBufferCGImageCompatibilityKey: true,
                kCVPixelBufferCGBitmapContextCompatibilityKey: true
            ]

            let status = CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32ARGB, attributes as CFDictionary, &pixelBuffer)

            guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
                return nil
            }

            CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(buffer)

            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(buffer), space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)

            guard let context = context else {
                CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
                return nil
            }

            context.draw(self, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

            CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))

            return buffer
        }
}

