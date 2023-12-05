//
//  UserLocation.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-03.
//

import Foundation
import MapKit

final class UserLocation: NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    
    init(locationManager: CLLocationManager? = nil) {
        self.locationManager = locationManager
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
//            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
            
        }else {
            print("Show an alert letting them lknow this is off and go turn it on")
        }
    }
    
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental control") //parental controls
        case .denied:
            print("Your have to give permissions to your device")
        case .authorizedAlways, .authorizedWhenInUse:
            
            break;
        @unknown default:
            break;
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
