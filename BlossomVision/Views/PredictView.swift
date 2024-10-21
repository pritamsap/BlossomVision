//
//  PredictView.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-16.
//

import SwiftUI
import AVFoundation

struct PredictView: View {
    
    @Environment(ViewModel.self) private var viewModel

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if let image = viewModel.currentFrame {
                                        
                    Image(decorative: image, scale: 1)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)

                        
                }
                else {
                    ContentUnavailableView("No camera Feed", systemImage: "xmark.circle").frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
            VStack(spacing: 10) {
                Spacer()
                HStack(spacing: 20) {
                    
                    Text(viewModel.predictedFlower.uppercased())
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.6)]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                        .shadow(radius: 5)

                    Button(action: {
                        if let image = viewModel.currentFrame {
                           viewModel.captureImage(image: image)
                       }
                    }, label: {
                        Text("Capture")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .shadow(radius: 5)
                    })
                }
                
            }
            .padding(.vertical, 10)
        }
        
    
    }
}

#Preview {
    PredictView()
}
