//
//  MoreView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        ZStack{
            Color.gray
            VStack(){
//                TopNavigation()
                NavigationView{
                    List{
                        LanguageSelectionView()
                        NavigationLink(destination: Navigation_CustomBackButton_Detail()) {
                           

                            Text(LocalizedStringKey("More_About_Event_Label"))
                        }
                        NavigationLink{
                            Text("About the Team")
                        }label:{
                            Text(LocalizedStringKey("More_About_Team_Label"))
                        }.navigationBarBackButtonHidden(true)
                        
                        
                        
                        //                    NavigationLink(LocalizedStringKey("More_About_Team_Label"), destination: Text("X"))
                        
                    }
//                    .listStyle(.inset)
                    Spacer()
                    
                    
                }.background(Color.cyan)
                    .frame(maxHeight: .infinity)
//                    .tint(.white)
                    
                    
            }
            Spacer()
        }
    }
}

#Preview {
    MoreView()
}


// Second Screen
struct Navigation_CustomBackButton_Detail: View {
    @State var searchText = ""
//    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    init() {
//            let customBackgroundImage = UIImage(named: "ottawa") // Replace "your_custom_image" with the name of your image asset
//            
//            let backgroundImage = UIImageView(image: customBackgroundImage)
//            backgroundImage.contentMode = .scaleAspectFill
//            
//            let coloredAppearance = UINavigationBarAppearance()
//            coloredAppearance.configureWithOpaqueBackground()
//            coloredAppearance.backgroundImage = customBackgroundImage
//            coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            
//            UINavigationBar.appearance().standardAppearance = coloredAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        }
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
    
    var body: some View {
        VStack {
            Text("About the Event")
        }
        .navigationTitle("Detail View")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
//                btnBack
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Spacer()
                                TextField("Search", text: $searchText)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                            }
                        }
        }
    }
}
