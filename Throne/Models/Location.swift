//
//  Location.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import CoreLocation

/// A position in the world.
struct Location: Codable, Hashable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

extension CLLocationCoordinate2D {
    init(_ location: Location) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}
