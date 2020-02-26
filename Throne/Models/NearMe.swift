//
//  NearMe.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import CoreLocation

final class NearMe: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var washrooms: [Washroom] = []
    @Published var currentLocation: Location?
    
    override init() {
        super.init()

        // start tracking location
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        if let location = locationManager.location {
            currentLocation = Location(location.coordinate)
        }

        fetchWashrooms()
    }
    
    /// Handle a location update.
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        NSLog("User location updated, start washrooms update.")
        let lastLocation = locations.last!
        currentLocation = Location(lastLocation.coordinate)
        fetchWashrooms()
    }
    
    private func fetchWashrooms() {
        if currentLocation == nil {
            NSLog("Cancelling washroom fetch: No user location.")
            return
        }
        
        ThroneEndpoint.fetchWashrooms(near: currentLocation) { washrooms in
            DispatchQueue.main.async {
                self.washrooms = washrooms
            }
        }
    }
}
