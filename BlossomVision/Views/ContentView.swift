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
    @State private var galleryOn: Bool = true
    @State private var flowerName: String = ""
    var body: some View {
        
        
        NavigationStack {
            
            VStack {
                HStack(spacing: 20) {
                    VStack {
                        Image("flower1")
                                      .resizable()
                                      .frame(width: 100, height: 180)
                                      .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                  .shadow(radius: 5)
                        Text("Love In Mist")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    VStack {
                        Image("flower2")
                                      .resizable()
                                      .frame(width: 100, height: 180)
                                      .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                  .shadow(radius: 5)
                        Text("Carnation")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    VStack {
                        Image("flower3")
                                      .resizable()
                                      .frame(width: 100, height: 180)
                                      .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                  .shadow(radius: 5)
                        Text("Marigold")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    
                    
                   
                    
     
                }.padding()
                
                Spacer()
                TextField("", text: $flowerName, prompt: Text("Search for flower...").foregroundColor(.gray))
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(red: 0.9, green: 0.95, blue: 1.0))
                    .clipShape(RoundedRectangle(cornerRadius: 30.0))
                    .shadow(radius: 10)
                    
            }.padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        switchCameraToggle.toggle()
                    } label: {
                        Text("\(Image(systemName: "camera.circle"))")
                            .foregroundStyle(.white)
                            .font(.title)
                            .background(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    }
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Text("Blossom").font(.title3).bold()
                }
                
            }
            
            
            .sheet(isPresented: $switchCameraToggle, content: {
                PredictView()
            })
            
            Spacer()
            
            
        }
            
    }
        
    
}

#Preview {
    ContentView()
}
