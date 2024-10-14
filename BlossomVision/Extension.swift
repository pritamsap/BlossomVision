//
//  CMSampleBuffer.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-14.
//

import Foundation
import AVFoundation
import CoreImage

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
