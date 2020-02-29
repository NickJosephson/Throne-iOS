//
//  Building.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class Building: Codable, ObservableObject {
    let id: Int
    let title: String
    let location: Location
    let distance: Double = 14.5
    let createdAt: Date
    let overallRating: Double
    let bestRatings: Washroom.Ratings
    let amenities: [Washroom.Amenity]?
    
    @Published var washrooms: [Washroom] = []
    
    init() {
        id = 0
        title = ""
        location = Location(latitude: 0, longitude: 0)
        createdAt = Date()
        overallRating = 0.0
        bestRatings = Washroom.Ratings(privacy: 0, toiletPaperQuality: 0, smell: 0, cleanliness: 0)
        amenities = []
    }
    
    func fetchWashrooms() {
        ThroneEndpoint.fetchWashrooms(in: self) { washrooms in
            DispatchQueue.main.async {
                self.washrooms = washrooms
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case distance
        case createdAt = "created_at"
        case overallRating = "overall_rating"
        case bestRatings = "best_ratings"
        case amenities
    }
}
