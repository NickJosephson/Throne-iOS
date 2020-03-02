//
//  Washroom.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

struct Washroom: Codable {
    let id: Int
    let title: String
    let location: Location
    let distance: Double = 14.5
    let gender: Gender
    let floor: Int
    let buildingID: Int
    let createdAt: Date
    let reviewsCount: Int?
    let overallRating: Double
    let averageRatings: Ratings
    let amenities: [Amenity]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case distance
        case gender
        case floor
        case buildingID = "building_id"
        case createdAt = "created_at"
        case reviewsCount = "review_count"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
    }
}
