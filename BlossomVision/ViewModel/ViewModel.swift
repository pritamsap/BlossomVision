//
//  ViewModel.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-14.
//

import Foundation
import CoreImage
import Observation
import UIKit
import CoreML
import SwiftUI

@Observable
class ViewModel {
    var currentFrame: CGImage?
    
    var predictedFlower: String = ""
    private let cameraManager = CameraManager()
    
    private let flowerClassifier = FlowerClassifier()
     
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    
    
    // async loop that continously waits for new images from preview Stream
    // @Main Actor ensures task is run on main thread
    func handleCameraPreviews() async {
        for await image in cameraManager.previewStream {
            Task { @MainActor in
                currentFrame = image
                if let currentFrame = currentFrame {
                    self.predictFlower(from: currentFrame)
                }
            }
        }
    }
    
    func predictFlower(from image: CGImage) {
        
        print("Original image size: \(image.width) x \(image.height)")
        guard let pixelBuffer = image.toPixelBuffer(size: CGSize(width: 227, height: 227)) else {
               print("Failed to convert image to pixel buffer")
               DispatchQueue.main.async {
                   self.predictedFlower = "Unknown"
               }
               return
           }
        
        print("Image successfully converted to CVPixelBuffer of size 227x227")

        
        do {
            print("Attempting to make prediction with Core ML model...")
            let prediction = try flowerClassifier.prediction(data: pixelBuffer)
            
            Task { @MainActor in
                self.predictedFlower = prediction.classLabel
                print(predictedFlower)
                
            }
        } catch let error {
            print("Error during prediction: \(error), \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.predictedFlower = "Error"
            }
        }
    }
    
    
}
