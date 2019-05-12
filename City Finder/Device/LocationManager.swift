//
//  LocationManager.swift
//  City Finder
//
//  Created by Akshay Kulkarni on 12/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServiceManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationServiceManager()
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private override init () {
        super.init()
    }
    
    func configure() {
        locationManager.requestWhenInUseAuthorization()
//        self.locationManager.delegate = self
//        currentLocation = locationManager.location
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        currentLocation = locationManager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //currentLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    class func isLocationPermissionGranted() -> Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return [.authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
    
    class func getAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
}

extension LocationServiceManager {
    
    var getCurrentLocation: CLLocation? {
        return currentLocation
    }
    
    var getAccuracy: CLLocationAccuracy? {
        return locationManager.desiredAccuracy
    }
    
}
