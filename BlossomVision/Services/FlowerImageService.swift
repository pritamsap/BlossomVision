//
//  FlowerImageService.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-18.
//

import Foundation
import SwiftUI
import Combine

class FlowerImageService {
    @Published var images: [UIImage] = []
    private let folderName = "flower_images"
    private let fileManager = LocalFileManager.instance
    
    
    init() {
        retrieveImagesList()
    }
    
    // Save the given image
    func saveFlowerImage(image: CGImage) {
        let imageName = "flower_\(UUID().uuidString)"
        print("Trying to save Image \(imageName)")
        fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
    }
    
    func retrieveImagesList() {
        images.removeAll()
        
        // Get the list of file names from the folder
        guard let imageNames = fileManager.getAllImages(folderName: folderName) else {
                   print("No images found in the folder.")
                   return
        }
        
        // Loop through each image name, load it, and append to the `images` array
        for imageName in imageNames {
                if let image = fileManager.getImage(imageName: imageName.replacingOccurrences(of: ".png", with: ""), folderName: folderName) {
                        images.append(image)
                } else {
                        print("Failed to load image: \(imageName)")
                }
        }
     
    }
    
    func deleteImageFolder() {
        fileManager.deleteFolder(folderName: folderName)
    }
    
}
