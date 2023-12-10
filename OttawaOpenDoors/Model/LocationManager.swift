//
//  UserLocation.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-03.
//

import Foundation

import MapKit


enum LOCATION_STATUS {
    case authorized
    case denied
    case undetermined
    case disabled
}


enum SUCCESS_OR_FAIL {
    case success
    case fail
}

enum ARRIVE_BY {
    case walk
    case drive
    case publicTransportation
}


struct Distance {
    var result: SUCCESS_OR_FAIL
    var point1: CLLocationCoordinate2D?
    var point2: CLLocationCoordinate2D?
    var value : Double?
}




struct TimeToReach{
    var result: SUCCESS_OR_FAIL
    var point1: CLLocationCoordinate2D?
    var point2: CLLocationCoordinate2D?
    var value : Double?
    var mode : ARRIVE_BY?
}


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion()
    @Published var locationAuthorizationStatus:LOCATION_STATUS = .undetermined
    var locationStatus:LOCATION_STATUS = .undetermined
    private let  locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManagerDidChangeAuthorization(locationManager)
        
        
    }
    
    private func getFailedDistanceResponse() -> Distance {
        let result = Distance(result: SUCCESS_OR_FAIL.fail)
        return result
    }
    
    func getDistance(targetLocation: CLLocationCoordinate2D?) -> CLLocationDistance?{

        guard locationAuthorizationStatus == .authorized else {
            // Handle unauthorized case, for example, return an error or a specific value
            return nil
        }
        
        
        guard let currentLocation = location else {
            // Handle the case when current location is not available, for example, return an error or a specific value
            return nil
        }
        
        guard let targetCoordinate = targetLocation else {
            // Handle the case when target location is not provided, for example, return an error or a specific value
            return nil
        }
        
        let targetLocation = CLLocation(latitude: targetCoordinate.latitude, longitude: targetCoordinate.longitude)
        
        let distance = currentLocation.distance(from: targetLocation)
        
        
        return distance
    }
    
    
    func getDistanceInKm(targetLocation: CLLocationCoordinate2D?) -> Double? {
        guard let distance = getDistance(targetLocation: targetLocation) else {
            return nil
        }

        let short = distance / 1000

        if short > 1000 {
            // over 1000km. Round it to the nearest 500
            return round(short / 500.0) * 500.0
        } else if short > 100 {
            // between 100 and 1000. Round it to the nearest 10
            return round(short / 10.0) * 10.0
        } else if short > 10 {
            // between 10 and 100. Round it to the nearest integer
            return round(short)
        } else if short > 3 {
            // between 3 and 10. Round it to the nearest 0.1
            return round(short * 10.0) / 10.0
        } else {
            // between 0 and 3. Round it to the nearest 0.01
            return round(short * 100.0) / 100.0
        }
    }
    
    
    private func _retrieveLocation()  {
        
        Task{
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined:
                    
                    self.locationManager.requestWhenInUseAuthorization()
                    break;
                case .restricted:
                    DispatchQueue.main.async {
                        self.locationAuthorizationStatus = .denied

                    }
                    
                case .denied:
                    DispatchQueue.main.async {
                        
                        self.locationAuthorizationStatus = .denied
                    }
                    
                case .authorizedAlways, .authorizedWhenInUse:
                    // Do nothing
                    break
                @unknown default:
                    break
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.locationAuthorizationStatus = .disabled
                }
                
            }
        }
    }
    
    
    func retrieveLocation()  {
        _retrieveLocation()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        retrieveLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        self.locationAuthorizationStatus = .authorized
    }
    
}

