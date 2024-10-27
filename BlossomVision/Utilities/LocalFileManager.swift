//
//  LocalFileManager.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-18.
//

import Foundation
import SwiftUI

struct LocalFileManager {
    static let instance = LocalFileManager()
    private init() {}
    
    
    
    func saveImage(image: CGImage, imageName: String, folderName: String) {
        
        // 1. Create the folder
        createImageFolder(folderName: folderName)
        
        // 2. Convert CGImage to UIImage
        let uiImage = UIImage(cgImage: image)
        
        
        // 3. Convert UIImage to data
        guard
            let data = uiImage.pngData(),
            let url = getImageURL(imageName: imageName, folderName: folderName) else { return }
        
        // 4. Save image to path
        do {
            try data.write(to: url)
            print("Saved Image")
        } catch let error {
            print("Error saving image. \(error)")
        }
     
    }
    
    
    // Retrieve the Image
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getImageURL(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path(percentEncoded: false)) else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path(percentEncoded: false))
    }
    
    
    // Create folder if needed
    private func createImageFolder(folderName: String) {
        guard let url = getFolderURL(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: false)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error  {
                print("Unable to create directory \(error)")
            }
            
            
        }
    }
    
    
    // Get the folder URL
    private func getFolderURL(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        return url.appending(path: folderName)
    }
    
    // Get the image URL
    private func getImageURL(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getFolderURL(folderName: folderName) else { return nil }
        return folderURL.appending(path: imageName + ".png")
    }
    
    
    // Get all the images based on folder URL
     func getAllImages(folderName: String) -> [String]? {
        guard let folderURL = getFolderURL(folderName: folderName) else { return nil }
        
        do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: folderURL.path(percentEncoded: false))
            return fileNames.filter { $0.hasSuffix(".png") }
        } catch let error {
            print("Unable to get the images. \(error)")
            return nil
        }
    }
    
    
    // Delete folder
    func deleteFolder(folderName: String) {
        guard let folderURL = getFolderURL(folderName: folderName) else {
            print("Error: Could not retrieve folder URL.")
            return
        }
        
        // Check if the folder exists at the URL
        if FileManager.default.fileExists(atPath: folderURL.path(percentEncoded: false)) {
            do {
                try FileManager.default.removeItem(at: folderURL)
                print("Folder deleted successfully.")
            } catch let error {
                print("Error deleting folder: \(error)")
            }
        } else {
            print("Error: Folder does not exist at the specified path.")
        }
    }
}
