//
//  Location.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let radius: Int = 1000 // meters

    static func currentLocation() -> Location? {
        let manager = CLLocationManager()
        if let currLocation = manager.location {
            return Location(latitude: currLocation.coordinate.latitude.binade, longitude: currLocation.coordinate.longitude.binade)
        } else {
            return nil
        }
    }
}
