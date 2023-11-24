//
//  Building.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-11-24.
//

import Foundation

protocol Entity {
    
}

struct Building: Codable, Identifiable, Equatable {
    var id: Int {
        return buildingId
    }
    var name: String{
        let englishName = nameEN ?? ""
        let frenchName = nameFR ?? ""
        return englishName + frenchName
    }
    
    let buildingId: Int
    let nameEN: String?
    let nameFR: String?
    let isNew: Bool?
    let addressEN: String?
    let addressFR: String?
    let descriptionEN: String?
    let descriptionFR: String?
    let websiteEN: String?
    let categoryEN: String?
    let saturdayStart: String?
    let saturdayClose: String?
    let sundayStart: String?
    let sundayClose: String?
    let isShuttle: Bool?
    let isPublicWashrooms: Bool?
    let isAccessible: Bool?
    let isFreeParking: Bool?
    let isBikeParking: Bool?
    let isPaidParking: Bool?
    let isFamilyFriendly: Bool?
    let image: String?
    let isGuidedTour: Bool?
    let isOCTranspoNearby: Bool?
    let imageDescriptionEN: String?
    let imageDescriptionFR: String?
    let latitude: Double?
    let longitude: Double?
    let websiteFR: String?
    let categoryId: Int?
    let categoryFR: String?
    let isOpenSaturday: Bool?
    let isOpenSunday: Bool?

    // Equatable conformance for comparison
    static func == (lhs: Building, rhs: Building) -> Bool {
        return lhs.name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ==
        rhs.name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}



//
//{
//buildingId: 1,
//nameEN: "AIDS Committee of Ottawa",
//nameFR: "Comité du SIDA d'Ottawa",
//isNew: false,
//addressEN: "19 Main St.",
//addressFR: "19, rue Main",
//descriptionEN: "The AIDS Committee of Ottawa (ACO) has served the HIV/AIDS community for 30 years, providing education and support services around HIV/AIDS. Built in 1961 and overlooking the Rideau Canal, the home of the ACO features a drop-in centre known as the Living Room - a place of comfort and care that pays tribute to the origins of the HIV/AIDS movement in Canada in the early 80s.",
//descriptionFR: "Le Comité du SIDA d'Ottawa (CSO) a servi la communauté du VIH / SIDA depuis plus de 30 ans, fournissant des services d'information et de soutien liés au VIH/SIDA. Construit en 1961 et donnant sur le canal Rideau, le bâtiment qui abrite le CSO comprend une halte-accueil appelée le Vivoir, où l'on trouve du réconfort et de l'aide et qui rend hommage aux origines du mouvement de lutte contre le VIH/SIDA au Canada au début des années 1980.",
//websiteEN: "http://aco-cso.ca/",
//categoryEN: "Community and/or Care centres",
//saturdayStart: "2018-06-02 10:00",
//saturdayClose: "2018-06-02 16:00",
//sundayStart: "",
//sundayClose: "",
//isShuttle: false,
//isPublicWashrooms: true,
//isAccessible: true,
//isFreeParking: true,
//isBikeParking: true,
//isPaidParking: false,
//isFamilyFriendly: true,
//image: "images/include/doors/aids_ottawa.jpg",
//isGuidedTour: true,
//isOCTranspoNearby: true,
//imageDescriptionEN: "Interior view of the AIDS Committee of Ottawa drop-in centre, known as the Living Room.",
//imageDescriptionFR: "Vue intérieure de la halte-accueil du Comité du sida d'Ottawa, appelée le Vivoir.",
//latitude: 45.4146211,
//longitude: -75.6809909,
//websiteFR: "http://aco-cso.ca/",
//categoryId: 7,
//categoryFR: "Centres communautaires/de soins",
//isOpenSaturday: true,
//isOpenSunday: false
//}
