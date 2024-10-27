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
import Combine

@Observable
class ViewModel {
    var flowerList: [UIImage] = []
    private var cancellables = Set<AnyCancellable>()  // To store Combine subscriptions

    var currentFrame: CGImage?
    
    var predictedFlower: String = ""
    private let cameraManager = CameraManager()
    
    private let flowerClassifier = FlowerClassifier()
    
    // Inject FlowerImageService to handle saving images
      private let flowerImageService = FlowerImageService()
      
     
    init() {
        Task {
            await handleCameraPreviews()
        }
        
        flowerImageService.$images
            .sink { [weak self] images in
                self?.flowerList = images
            }
            .store(in: &cancellables)
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
        guard let pixelBuffer = image.toPixelBuffer(size: CGSize(width: 227, height: 227)) else {
               print("Failed to convert image to pixel buffer")
               DispatchQueue.main.async {
                   self.predictedFlower = "Unknown"
               }
               return
           }
        
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
    
    
    func captureImage(image: CGImage) {
        flowerImageService.saveFlowerImage(image: image)
        print("Image captured and saved.")
    }
}
