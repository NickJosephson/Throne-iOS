//
//  LocationManager.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-28.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

import Combine
import CoreLocation

/// Manage the state of user location.
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager() // Shared instance to use across application
    
    private let locationManager = CLLocationManager()
    private var loginSubscription: AnyCancellable!
    
    @Published var currentLocation: Location?
    
    override init() {
        super.init()
        
        // start tracking location
        locationManager.delegate = self
        locationManager.distanceFilter = 20.0 // meters
        locationManager.startUpdatingLocation()
        if let location = locationManager.location {
            currentLocation = Location(location.coordinate)
        }
        
        #if !STUBBED
            // request location permission after login
            loginSubscription = LoginManager.shared.$isLoggedIn
                .filter { $0 }
                .sink { _ in
                    self.locationManager.requestWhenInUseAuthorization()
                }
        #endif
    }
    
    /// Handle a location update.
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let newLocation = Location(locations.last!.coordinate)
        
        DispatchQueue.main.async {
            if newLocation != self.currentLocation {
                NSLog("User location updated: \(newLocation)")
                self.currentLocation = newLocation
            }
        }
    }
    
}
