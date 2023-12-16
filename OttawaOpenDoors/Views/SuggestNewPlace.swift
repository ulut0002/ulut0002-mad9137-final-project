//
//  SuggestNewPlace.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import SwiftUI
import Firebase

enum SuggestionStep {
    case idle
    case submitting
}

struct SuggestNewPlace: View {
    @EnvironmentObject var appLanguageManager: AppLanguageManager
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @State var developerLinkActive: Bool = false
    
    @State var buildingDescription: String = ""
    @State var buildingCategory: BuildingCategory = .academic
    @State var buildingName: String = ""
    
    @State private var nameFieldFocused: Bool = false
    @State private var descriptionFieldFocused: Bool = false
    @State private var categorySelection: BuildingCategory = .academic
    
    @State private var nameFieldError: String = ""
    @State private var descriptionFieldError: String = ""
    @State private var suggestionResult: String = ""
    @State private var suggestionSubmitStep : SuggestionStep = .idle

    
    //Suggest_New_Place_Building_Category
    //Suggest_New_Place_Building_Description
    //Suggest_New_Place_Building_Name

    
    private func unfocusAll(){
        nameFieldFocused = false
        descriptionFieldFocused = false
    }
    
    private func submitSuggestion()  async {
        nameFieldError = ""
        descriptionFieldError = ""
        suggestionResult = ""
        suggestionSubmitStep = .submitting
        
        let buildingNameClean = buildingName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        let buildingDescriptionClean = buildingDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (buildingNameClean.isEmpty){
            nameFieldError = "Suggestion_Name_Missing".localizeString(string: appLanguageManager.locale.identifier)
        }
        
        if (buildingDescriptionClean.isEmpty){
            descriptionFieldError = "Suggestion_Description_Missing".localizeString(string: appLanguageManager.locale.identifier)
        }
        
        if (!nameFieldError.isEmpty || !descriptionFieldError.isEmpty){
            return
        }
        
        
        
        do{
            let db = Firestore.firestore()
            let newSuggestion = Suggestion(name: buildingName,
                                           description: buildingDescription,
                                           category: categorySelection.translate(appLanguageManager.locale.identifier))
            
            let suggestionData = try newSuggestion.toFirestore()

            let ref = db.collection("Suggestions")
            try await ref.addDocument(data: suggestionData)
            
            
            suggestionResult = "Suggestion_Successful".localizeString(string: appLanguageManager.locale.identifier)
            buildingName = ""
            buildingDescription = ""
            buildingCategory = .academic
            categorySelection = .academic
            suggestionSubmitStep = .idle
        }catch{
            suggestionResult = "Suggestion_Fail".localizeString(string: appLanguageManager.locale.identifier)
            suggestionSubmitStep = .idle
        }
        
    }
    
    var body: some View {
            ScrollView{
                VStack( spacing: 12){
                    VStack(alignment: .center){

                        
                        Text("Suggest_New_Place_Text".localizeString(string: appLanguageManager.locale.identifier))
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)

                        
                        Image("placeHolderLogoFaded").resizable().aspectRatio(contentMode: .fit).frame(width: 200,height: 300)

                    }
                   
                    Divider()
                    
                    HStack{
                        Text("Suggest_New_Place_Details".localizeString(string: appLanguageManager.locale.identifier))
                            .bold()
                            .font(.title3)
                        Spacer()
                    }.padding(.top, 24)
                    
                    VStack{
                        HStack{
                            Text("Suggest_New_Place_Building_Name".localizeString(string: appLanguageManager.locale.identifier))
                                .frame(width: 100, alignment: .leading)


                            Spacer()
                            TextField("", text: $buildingName)
                                .textInputAutocapitalization(.never)
                                 .disableAutocorrection(true)
                                 .textFieldStyle(.roundedBorder)
                                 .onChange(of: buildingName, {
                                     nameFieldError = ""
                                 })

                            
                                 
                                 

                        }
                        if (!nameFieldError.isEmpty){
                            HStack{
                                Spacer()
                                Text(nameFieldError).font(.caption).multilineTextAlignment(.center)
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        HStack{
                            Text("Suggest_New_Place_Building_Description".localizeString(string: appLanguageManager.locale.identifier))
                                .frame(width: 100, alignment: .leading)

                            
                            TextField("", text: $buildingDescription)
                                .textInputAutocapitalization(.never)
                                 .disableAutocorrection(true)
                                 .textFieldStyle(.roundedBorder)
                                 .onChange(of: buildingDescription, {
                                     descriptionFieldError = ""

                                 })
                                 

                        }
                        
                        if (!descriptionFieldError.isEmpty){
                            HStack{
                                Spacer()
                                Text(descriptionFieldError).font(.caption).multilineTextAlignment(.center)
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        HStack{
                            Text("Suggest_New_Place_Building_Category".localizeString(string: appLanguageManager.locale.identifier))
                                .frame(width: 100, alignment: .leading)
                            Spacer()

                            
                            Picker("", selection: $categorySelection, content: {
                                Text(BuildingCategory.academic.translate(appLanguageManager.locale.identifier)).tag(BuildingCategory.academic)
                                Text(BuildingCategory.business_foundatation.translate(appLanguageManager.locale.identifier))
                                    .tag(BuildingCategory.business_foundatation)
                                
                                Text(BuildingCategory.community_center.translate(appLanguageManager.locale.identifier))
                                    .tag(BuildingCategory.community_center)

                                Text(BuildingCategory.embassy.translate(appLanguageManager.locale.identifier))
                                    .tag(BuildingCategory.embassy)

                                Text(BuildingCategory.functional_building.translate(appLanguageManager.locale.identifier))
                                    .tag(BuildingCategory.functional_building)

                                Text(BuildingCategory.gallery_theatre.translate(appLanguageManager.locale.identifier))                                    .tag(BuildingCategory.gallery_theatre)

                                Text(BuildingCategory.government.translate(appLanguageManager.locale.identifier))                                    .tag(BuildingCategory.government)

                                Text(BuildingCategory.museum_archive_historic.translate(appLanguageManager.locale.identifier))                                    .tag(BuildingCategory.museum_archive_historic)

                               

                                Text(BuildingCategory.religious_building.translate(appLanguageManager.locale.identifier))                                    .tag(BuildingCategory.religious_building)

                                
                                Text(BuildingCategory.sports_leisure.translate(appLanguageManager.locale.identifier))                                    .tag(BuildingCategory.sports_leisure)

                                Text(BuildingCategory.other.translate(appLanguageManager.locale.identifier))                               .tag(BuildingCategory.other)
                            })
                                 

                        }
                        
                        HStack{
                            Spacer()
                            Button("Suggest_New_Place_Submit_Label".localizeString(string: appLanguageManager.locale.identifier),
                                   action: {
                                Task{
                                    await submitSuggestion()
                                }
                            }).buttonStyle(.borderedProminent)
                                .disabled((!networkMonitor.isConnected) || (suggestionSubmitStep == .submitting))
                              
                            
                            Spacer()
                        }.padding(.top, 18)
                        
                        if (!suggestionResult.isEmpty){
                            HStack{
                                Text(suggestionResult).font(.caption).multilineTextAlignment(.center)
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        if (!networkMonitor.isConnected){
                            Text("Network_Not_Connected".localizeString(string: appLanguageManager.locale.identifier))
                                .foregroundStyle(COLORS.DARK_TEXT_COLOR_LIGHT)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .padding(.top, 12)
                        }
                        
                    }.tint(COLORS.BRAND_COLOR)
                    
                    
                    
                    
                    Spacer()
//
                }.padding(24)
            }
            .toolbarBackground(.visible, for: .navigationBar, .tabBar)
            .toolbarBackground(COLORS.TOOLBAR_COLOR)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("Suggest_New_Place_Title".localizeString(string: appLanguageManager.locale.identifier))
                        .bold()
                        .font(.title3)
                        .padding(.leading, 4)
                        .foregroundStyle(COLORS.LIGHT_TEXT_COLOR)
                }
                
                
            }.tint(.white)
            
        }
    
}


struct SuggestNewPlace_Previews: PreviewProvider {
    static var previews: some View{
        let location = LocationManager()
        let language = AppLanguageManager()
        let networkMonitor = NetworkMonitor()
        SuggestNewPlace()
            .environmentObject(location)
            .environmentObject(language)
            .environmentObject(networkMonitor)
    }
}
