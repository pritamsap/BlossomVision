//
//  ContentView.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-04.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var viewModel  = ViewModel()
    var body: some View {
        CameraView(image: $viewModel.currentFrame)
    }
}


#Preview {
    ContentView()
}
