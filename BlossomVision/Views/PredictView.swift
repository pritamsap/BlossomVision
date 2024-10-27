//
//  PredictView.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-16.
//

import SwiftUI
import AVFoundation

struct PredictView: View {
    
    @State private var viewModel  = ViewModel()

    //@Environment(ViewModel.self) private var viewModel
    var gradientBackground = LinearGradient(
            gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.white.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                if let image = viewModel.currentFrame {
                                        
                    Image(decorative: image, scale: 1)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                
                    VStack() {
                        Spacer()
                        Text(viewModel.predictedFlower.uppercased())
                            .font(.caption)
                            .foregroundStyle(.white)
                            .frame(width: 230, height: 2)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.white.opacity(0.3)]),
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 50.0))
                            .opacity(0.9)
                            .padding(.bottom, 20)
                            
                        HStack() {
                            Spacer()
                            Button(action: {
                                if let image = viewModel.currentFrame {
                                   viewModel.captureImage(image: image)
                               }
                            }, label: {
                                Circle()
                                    .frame(width: 80, height: 80)
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.9), Color.white.opacity(0.9)]),
                                                                    startPoint: .topLeading,
                                                                    endPoint: .bottomTrailing))
                                    .shadow(radius: 10)
                                    .overlay(
                                                Circle()
                                                    .stroke(Color.gray, lineWidth: 4) // Adjust color and line width for the border
                                            )
                            })
                            Spacer()
                        }
                        .padding(.bottom, 90)
                    }
                        
                }
                else {
                    ContentUnavailableView("No camera Feed", systemImage: "xmark.circle").frame(width: geometry.size.width, height: geometry.size.height)
                   
                  
                }
            }
            
        }
        
    
    }
}

#Preview {
    PredictView().environment(ViewModel())
}
