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
    @Published var buildings: [Building] = []
    @Published var currentLocation: Location?
    
    override init() {
        super.init()

        // start tracking location
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        if let location = locationManager.location {
            currentLocation = Location(location.coordinate)
        }

        update()
    }
    
    /// Handle a location update.
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        NSLog("User location updated, start washrooms update.")
        let lastLocation = locations.last!
        
        DispatchQueue.main.async {
            self.currentLocation = Location(lastLocation.coordinate)
        }
        
        update()
    }
    
    private func update() {
        if currentLocation == nil {
            NSLog("Cancelling washroom fetch: No user location.")
            return
        }
        
        ThroneEndpoint.fetchWashrooms(near: currentLocation) { washrooms in
            DispatchQueue.main.async {
                self.washrooms = washrooms
            }
        }
        ThroneEndpoint.fetchBuildings(near: currentLocation) { buildings in
            DispatchQueue.main.async {
                self.buildings = buildings
            }
        }
    }
}
