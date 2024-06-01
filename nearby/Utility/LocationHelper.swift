//
//  LocationHelper.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import Foundation
import CoreLocation

protocol LocationProtocol: AnyObject{
    func sendLocationData(location : CLLocation)
}
class LocationHelper:NSObject, CLLocationManagerDelegate{
    
    weak var delegate: LocationProtocol?
    let locationManager: CLLocationManager
    
    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        checkLocation()
        
    }
    
    func requestPermission(){
        locationManager.requestAlwaysAuthorization()
    }
    
    func fetchLocation(){
        // Request a user’s location once
        locationManager.requestLocation()
    }
    
    func startUpdating(){
        locationManager.startUpdatingLocation()
    }
    func stopUpdating(){
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            print(latitude)
            print(longitude)
            
            delegate?.sendLocationData(location: location)
            stopUpdating()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("location failed", error)
        
    }
    
    private func checkLocation(){
        
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // Handle case
           print("access allowed")
        case .notDetermined:
            // Handle case
            requestPermission()
        case .restricted, .denied:
            print("no access")
        default:
            print("no access")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            startUpdating()
        }else{
            print(manager.authorizationStatus.rawValue)
        }
    }
}
