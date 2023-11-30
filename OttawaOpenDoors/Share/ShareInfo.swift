//
//  SimpleShareInfo.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//
import SwiftUI

struct ShareInfo: View {
    @State var searchText:String = ""
    @State var isSearchPresented:Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
           
                List{
                    ShareLink(item: URL(string: "https://www.google.com")!)
                    ShareLink("MAD Website", item: "This is MADD Website")
                    ShareLink(
                        item: "Share Email",
                        subject: Text("Assignment Due Dec 15"),
                        message: Text("This is a friendly reminder.")
                    ) {
                        Label(
                            title: { Text("Label") },
                            icon: { Image(systemName: "42.circle") }
                        )
                    }
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")
                    Text("a")

                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Label(
                        title: {
                          
                                HStack{
                                    Text("Ottawa Open Doors").bold().font(.title)

                                }.padding(.vertical, 12)
                         
                           
                        },
                        icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
                    ).labelStyle(TitleOnlyLabelStyle())
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Label(
                        title: { Text("Search") },
                        icon: { Image(systemName: "magnifyingglass")
                        }
                    ).onTapGesture {
                        isSearchPresented.toggle()
                    }
                }
            }
        }
    }
}

struct ShareInfo_Previews: PreviewProvider {
    static var previews: some View {
        ShareInfo()
    }
}

