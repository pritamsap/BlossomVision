//
//  ContentView.swift
//  BlossomVision
//
//  Created by pritam on 2024-10-04.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
    @State private var switchCameraToggle : Bool = false
    @State private var galleryEmpty: Bool = true
    var gradientBackground = LinearGradient(
            gradient: Gradient(colors: [Color.gray.opacity(0.2), Color.white.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    
    @State var flowervm = FlowerImageViewModel()

    let columns = [
          GridItem(.flexible(), spacing: 20),
          GridItem(.flexible(), spacing: 20),
          GridItem(.flexible(), spacing: 20)
      ]
    var body: some View {

        NavigationStack {
            
            Spacer()
            SampleView()

            VStack {
                if flowervm.galleryEmpty {
                    Spacer()
                    Text("Gallery Empty  \(Image(systemName: "photo"))")
                    Spacer()
                   
                
                }else {
                    HStack {
                        Text("Flower Collection")
                            .foregroundStyle(.white)
                            .opacity(0.7)
                            
                        Spacer()
                        
                        Button(action: {
                            flowervm.deleteImagefolder()
                        }, label: {
                            Text("Delete")
                                .foregroundStyle(.white)
                                .opacity(0.7)
                                .frame(width: 100, height: 30)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 7.0))
                        })
                    }
                    .padding(.horizontal, 5)
                         
                    ScrollView(showsIndicators: false) {
                                   LazyVGrid(columns: columns, spacing: 20) {
                                       ForEach(flowervm.images, id: \.self) { image in
                                           VStack {
                                               Image(uiImage: image)
                                                   .resizable()
                                                   .scaledToFill()
                                                   .frame(width: 110, height: 110)
                                                   .clipShape(RoundedRectangle(cornerRadius: 15))
                                                   .shadow(radius: 3)
                                           }
                                           .padding(3)
                                           .background(Color.white)
                                           .clipShape(RoundedRectangle(cornerRadius: 15))
                                           .shadow(radius: 2)
                                           .opacity(0.8)
                                       }
                                   }
                                   .padding(.horizontal, 10)
                               }
                    .padding(.top, 10)
                    .ignoresSafeArea()

                               
                               Spacer()
                }


              
                    
            }.padding()
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        switchCameraToggle.toggle()
                    } label: {
                        Text("\(Image(systemName: "camera.macro"))")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 70, height: 30)
                            .background(gradientBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            .shadow(radius: 5)
                    }
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Blossom").font(.title2).fontWeight(.semibold)
                }
                
    
                
            }
            
            
            .sheet(isPresented: $switchCameraToggle, content: {
                PredictView()
            })
            
            Spacer()
            
            
        }
            
    }
        
    
}

 
struct SampleView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .frame(width: 370, height: 100)
                .foregroundStyle(.white)
                .shadow(radius: 5)
            
            Text("Flowers are variant live things. There are millions of variety of flowers available around the world to be appreiciated.")
                .foregroundStyle(.gray)
                .font(.headline)
                .opacity(0.9)
                .padding(.horizontal, 30)
        }
    }
}

#Preview {
    ContentView()
}
