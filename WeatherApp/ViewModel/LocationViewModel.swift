//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 13/12/24.
//

import Foundation
import CoreLocation

class LocationViewModel : NSObject, ObservableObject,CLLocationManagerDelegate {
    // Creating an instance of CLLocationManager, the framework we use to get the coordinates
    let locationManager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    @Published var city: String?
    @Published var isLoading = false
    
    override init(){
        super.init()
        // Assigning a delegate to our CLLocationManager instance
        locationManager.delegate = self
    }
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse:  // Location services are available.
                // Insert code here of what should happen when Location services are authorized
                isLoading = true
                locationManager.requestLocation()
                break
                
            case .restricted, .denied:  // Location services currently unavailable.
                // Insert code here of what should happen when Location services are NOT authorized
                isLoading = false
                break
                
            case .notDetermined:
                // Authorization not determined yet.
                isLoading = true
                manager.requestWhenInUseAuthorization()
                break
                
            default:
                break
            }
        }
    
    // Set the location coordinates to the location variable
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            loc.fetchCityAndCountry(completion: { [weak self](city, country, error) in
                if let city = city {
                    self?.city = city
                }
                self?.isLoading = false
            })
        }
    }

    // This function will be called if LocationManger run into an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
    
    
}


