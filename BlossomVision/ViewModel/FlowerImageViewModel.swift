//
//  FlowerImageViewModel.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-27.
//
import Foundation
import SwiftUI
import Combine


@Observable class FlowerImageViewModel {
     var images: [UIImage] = []
     var galleryEmpty: Bool = false

    
    private let imageService = FlowerImageService()
    private var cancellables = Set<AnyCancellable>()

    
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        imageService.$images
            .sink { [weak self] _ in
                self?.galleryEmpty = false
                       } receiveValue: { [weak self] returnedImagesList in
                           self?.images = returnedImagesList
                       }
                       .store(in: &cancellables)
    }
    
    func deleteImagefolder() {
        imageService.deleteImageFolder()
    }
    

}
