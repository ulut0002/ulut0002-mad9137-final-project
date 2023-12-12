//
//  SplashScreen.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import SwiftUI

// source: https://youtu.be/0ytO3wCRKZU`

struct SplashScreen: View {
    var hideSplash: () -> Void
    
    
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    
    
    
    var body: some View {

        
        
        ZStack{
            COLORS.BRAND_COLOR.ignoresSafeArea()
            VStack{
                VStack{
                    Image("ic_logo_new").resizable().frame(width: 100, height: 100).aspectRatio(contentMode: .fit)
                    
                    //                Text("Splash_Screen_Header".localizeString(string: appLanguageManager.locale.identifier))
                    //
                    Text("Splash_Screen_Header".localizeString(string: appLanguageManager.locale.identifier))
                                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                        .bold()
                    
                    Text("Splash_Screen_Subtitle".localizeString(string: appLanguageManager.locale.identifier))
                                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                    
                }.scaleEffect(size)
                    .opacity(opacity)
                    .onAppear(){
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
//                    self.isActive = true
                    hideSplash()
                }
            }
        }
    }
}


