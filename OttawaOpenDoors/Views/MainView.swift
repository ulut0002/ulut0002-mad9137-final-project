//
//  MainView.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var appModel:AppModel
    @State var isSheetPresented = false
    
    
    var body: some View {

        NavigationView{
            VStack(alignment: .leading){
                    
                    if (appModel.fetchStatus == .fetchingFirstTime){
                        ProgressView("Fetching...")
                    }
                    
                    if (appModel.fetchStatus == .idle){
                            Spacer()
                            Text("Main").foregroundColor(.blue)
                            Spacer()
                    }
                } .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        Label(
                            title: {
                              
                                    HStack{
                                        AvatarView(image:  Image("ic_logo"), size: 48)
                                        Text("Ottawa Open Doors").bold().font(.title3)
                                            .padding(.leading, 4)
                                        Spacer()
                                    }.padding(.vertical, 12)
                             
                               
                            },
                            icon: { Image(systemName: "42.circle") }
                        ).labelStyle(TitleOnlyLabelStyle())
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Label(
                            title: { Text("Search") },
                            icon: { Image(systemName: "magnifyingglass")
                            }
                        ).onTapGesture {
                            // TODO: open the search sheet
                            isSheetPresented.toggle()
                        }
                    }
                }
                .sheet(isPresented: $isSheetPresented, content: {
                    SearchFiltersView(appModel: appModel, isSheetPresented: $isSheetPresented)
                })
               
            }
       
            
            
       
        
    }
    
    
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(appModel: AppModel())
        }
    }


    
    
    //    .toolbar{
    //        ToolbarItem{
    //            Text("Hi")
    //        }
    //    }
    
    
    
    //                        ScrollView{
    //                            LazyVStack{
    //                                ForEach(appModel.filteredBuildings[appModel.selectedLanguage] ?? [], id: \.id){ building in
    //                                    VStack{
    //                                        ZStack(alignment: .top){
    //
    //                                            Image(building.imageResourceName)
    //                                                .resizable()
    //                                                .aspectRatio(contentMode: .fill)
    //                                                .frame(width: UIScreen.main.bounds.width, height: 140)
    //                                                .clipped()
    //                                                .overlay(
    //                                                    HStack() {
    //                                                        Spacer()
    //                                                        HStack {
    //                                                            Image(systemName: "heart")
    //                                                                .foregroundColor(.white)
    //                                                                .padding(4)
    //
    //                                                            Image(systemName: "square.and.arrow.up")
    //                                                                .foregroundColor(.white)
    //                                                                .padding(4)
    //                                                        }
    //
    //                                                        .background(Color.black.opacity(0.6))
    //                                                        //                                                        .cornerRadius(10)
    //                                                        .padding(10)
    //                                                    }
    //                                                )
    //
    //
    //
    //
    //
    //                                        }
    //                                        Text(building.name!).background(Color.white)
    //                                    }.background(Color.white)
    //                                }.onTapGesture {
    //                                }
    //
    //                            }.background(Color.white)
    //                        }.shadow(radius:2)
    //                            .listStyle(PlainListStyle())
    //                            .frame(height: .infinity)
    //                            .listRowSeparator(.hidden)
    //                            .padding(0)
}
