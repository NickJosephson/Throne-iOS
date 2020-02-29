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
    static var shared = LocationManager() // Shared instance to use across application
    
    private let locationManager = CLLocationManager()
    private var loginSubscription: AnyCancellable!
    
    @Published var currentLocation: Location?

    override init() {
        super.init()

        // start tracking location
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        if let location = locationManager.location {
            currentLocation = Location(location.coordinate)
        }
        
        // request location permission after login
        loginSubscription = LoginManager.shared.$isLoggedIn
            .filter { $0 }
            .sink { _ in
                self.locationManager.requestWhenInUseAuthorization()
            }
    }
    
    /// Handle a location update.
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        NSLog("User location updated.")
        let lastLocation = locations.last!
        
        DispatchQueue.main.async {
            self.currentLocation = Location(lastLocation.coordinate)
        }
    }
    
}
