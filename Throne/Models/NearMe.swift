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
    @Published var washrooms: [Washroom] = []
    
    private let locationManager = CLLocationManager()
    private var currentLocation = Location.currentLocation()
    
    override init() {
        super.init()
        
        fetchWashrooms()
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        NSLog("User location updated, start washrooms update.")
        let lastLocation = locations.last!
        currentLocation = Location(latitude: lastLocation.coordinate.latitude.binade, longitude: lastLocation.coordinate.longitude.binade)
        fetchWashrooms()
    }
    
    private func fetchWashrooms() {        
        ThroneEndpoint.fetchWashrooms(near: currentLocation) { washrooms in
            DispatchQueue.main.async {
                self.washrooms = washrooms
            }
        }
    }
}
