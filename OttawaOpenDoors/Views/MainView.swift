//
//  MainView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appModel:AppModel
    
    
    
    var body: some View {
        
        ZStack(){
            
            
            Color.cyan
            //            LinearGradient(gradient: Gradient(colors: [Color.backgroundStart, Color.backgroundEnd]), startPoint: .topTrailing, endPoint: .bottomLeading)
            
            VStack{
                TopNavigation(appModel: appModel)
                VStack{
                    
                }
                VStack{
                    
              
                    List{
                        LazyVStack{
                            
                            ForEach(appModel.masterBuildings){ building in
                                Text("AA")
                                VStack{
                                    ZStack(alignment: .topLeading){
                                        
                                        Image("aids_ottawa")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: .infinity, height: 150)
                                            .clipped()
                                        
                                        HStack() {
                                            Spacer()
                                            HStack {
                                                Image(systemName: "heart")
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                
                                                Image(systemName: "square.and.arrow.up")
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                            }
                                            .background(Color.black.opacity(0.6))
                                            .cornerRadius(10)
                                            .padding(10)
                                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            
                            
                        }.clipShape(RoundedRectangle(cornerSize:
                                                        CGSize(width: 10, height: 10)))
                        
                    }.shadow(radius:2).listStyle(PlainListStyle())
                    
                }

            }
            .frame(maxHeight: .infinity)
            
        }
    }
    
}
