//
//  Washroom.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Washroom: Codable {
    let id: Int
    let title: String
    let location: Location
    let gender: Washroom.Gender
    let floor: Int
    let buildingID: Int
    let createdAt: Date
    let overallRating: Double
    let averageRatings: [String: Double]
    let amenities: [String]
    
    enum Gender: String, Codable {
        case all
        case women
        case men
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case gender
        case floor
        case buildingID = "building_id"
        case createdAt = "created_at"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
    }
}
