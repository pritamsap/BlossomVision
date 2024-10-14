//
//  CameraView.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-14.
//

import SwiftUI

struct CameraView: View {
    @Binding var image: CGImage?

    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                Image(decorative: image, scale: 1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    
            }
            else {
                ContentUnavailableView("No camera Feed", systemImage: "xmark.circle").frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    // For previews, we need to provide a temporary binding
    struct PreviewWrapper: View {
        @State private var image: CGImage? = nil  // Temp state for preview
        
        var body: some View {
            CameraView(image: $image)
        }
    }

    return PreviewWrapper()
}
