//
//  Filter.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-09.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Represent filtering options that can be applied to Washroom or Building lists.
struct Filter: Equatable, Codable {
    var amenities: [Amenity] = []
    var radius: Double = 50.0 // kilometers
    var showEmptyBuildings = false
    
    /// A human readable description of the radius.
    var radiusDescription: String {
        get {
            if radius < 1.0 {
                let value = String(format: "%.0f", radius * 1000.0)
                return "\(value) m"
            } else {
                let value = String(format: "%.1f", radius)
                return "\(value) km"
            }
        }
    }
}
