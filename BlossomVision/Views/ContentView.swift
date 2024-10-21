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
    @State private var galleryEmpty: Bool = false
    @State private var viewModel  = ViewModel()

    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {

        NavigationStack {
            
            VStack {
                if galleryEmpty {
                    Spacer()
                    Text("Gallery Empty  \(Image(systemName: "photo"))")
                    Spacer()
                }else {
                    //GalleryView()
                    ScrollView {
                                   LazyVGrid(columns: columns, spacing: 20) {
                                       ForEach(viewModel.flowerList, id: \.self) { image in
                                           VStack {
                                               Image(uiImage: image)
                                                   .resizable()
                                                   .scaledToFit()
                                                   .frame(width: 100, height: 150)
                                                   .clipShape(RoundedRectangle(cornerRadius: 10))
                                                   .shadow(radius: 5)
                                               Text("Flower Name") // Placeholder for flower names
                                                   .font(.caption)
                                                   .foregroundColor(.white)
                                           }
                                       }
                                   }
                                   .padding()
                               }
                               
                               Spacer()
                }


              
                    
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
                PredictView().environment(viewModel)
            })
            
            Spacer()
            
            
        }
            
    }
        
    
}


struct GalleryView: View {
    var body: some View {
        Text("Hello")
        
        //
        //        HStack(spacing: 20) {
        //            VStack {
        //                Image("flower1")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Love In Mist")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //            VStack {
        //                Image("flower2")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Carnation")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //            VStack {
        //                Image("flower3")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Marigold")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //
        //
        //        }.padding()
        //
        //        HStack(spacing: 20) {
        //            VStack {
        //                Image("flower4")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Canturbur Belly")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //            VStack {
        //                Image("flower5")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Rose")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //            VStack {
        //                Image("flower6")
        //                              .resizable()
        //                              .frame(width: 100, height: 180)
        //                              .clipShape(RoundedRectangle(cornerRadius: 15.0))
        //                          .shadow(radius: 5)
        //                Text("Sweet Pea")
        //                    .font(.caption)
        //                    .fontWeight(.semibold)
        //                    .foregroundStyle(.gray)
        //            }
        //
        //
        //        }.padding()
        //
        //   }
        
        // }
    }
}


#Preview {
    ContentView()
}
