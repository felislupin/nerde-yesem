//
//  LocationManager.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

open class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation? {
        didSet {
            notifyLocation()
        }
    }
    
    public static let shared = LocationManager()
    
    
    public func initManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    public func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
    
    public func startListener() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    public func stopListener() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func notifyLocation() {
        if let safeLocation = currentLocation {
            let dic: [AnyHashable: Any] = ["currentLocation": safeLocation]
            NotificationCenter.default.post(name: .locationUpdated, object: nil, userInfo: dic)
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentLocation = locations.first
    }
}

