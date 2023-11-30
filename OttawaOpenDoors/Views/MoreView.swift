//
//  MoreView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MoreView: View {
    var appModel:AppModel
    
    var body: some View {
        ZStack{
            Color.red
            
            VStack(){
                VStack{
                    //Do not remove this. It makes the additional space disappear
                }
                
                VStack{
                    MoreMenu()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
        
        
    }
    
}

struct MoreMenu:View{
    var body: some View{
        NavigationView{
            List{
                LanguageSelectionView()
                NavigationLink{
                    Text("About the Event").navigationBarBackButtonHidden(true)
                }label:{
                    Text(LocalizedStringKey("More_About_Event_Label"))
                }
                    
                
                NavigationLink{
                    Text("About the Team")                        .navigationBarBackButtonHidden(true)

                }label:{
                    Text(LocalizedStringKey("More_About_Team_Label"))
                }
            }
        }
        .frame(maxHeight: .infinity)        
    }
}

#Preview {
    MoreView(appModel: AppModel())
}
