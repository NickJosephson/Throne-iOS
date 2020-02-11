//
//  Building.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Building: Codable {
    let id: Int
    let title: String
    let location: Location
    let createdAt: Date
    let overallRating: Double
    let bestRatings: [String: Double]
    let amenities: [String]
        
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case createdAt = "created_at"
        case overallRating = "overall_rating"
        case bestRatings = "best_ratings"
        case amenities
    }
}
