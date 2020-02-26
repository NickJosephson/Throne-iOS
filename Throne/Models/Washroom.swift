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
        case gender
        case floor
        case buildingID = "building_id"
        case createdAt = "created_at"
        case reviewsCount = "reviews_count"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
    }
    
    enum Gender: String, Codable {
        case all
        case women
        case men
        
        var description: String {
            get {
                switch self {
                case .women: return "Women"
                case .men: return "Men"
                case .all: return "All"
                }
            }
        }
        
        var emoji: String {
            get {
                switch self {
                case .women: return "🚺"
                case .men: return "🚹"
                case .all: return "🚻"
                }
            }
        }
    }
        
    struct Ratings: Codable {
        let privacy: Double
        let toiletPaperQuality: Double
        let smell: Double
        let cleanliness: Double
        
        private enum CodingKeys: String, CodingKey {
            case privacy
            case toiletPaperQuality = "toilet_paper_quality"
            case smell
            case cleanliness
        }
    }
    
    enum Amenity: String, Codable {
        case contraception = "Contraception"
        case lotion = "Lotion"
        case automaticToilet = "Automatic Toilet"
        case airDryer = "Air Dryer"
        case shower = "Shower"
        case soap = "Soap"
        case attendant = "Attendant"
        case babyChangeStation = "Baby Changing Station"
        case urinal = "Urinal"
        
        var emoji: String? {
            get {
                switch self {
                case .shower: return "🚿"
                case .lotion: return "🧴"
                case .babyChangeStation: return "👶"
                case .attendant: return "🛎"
                case .soap: return "🧼"
                case .airDryer: return "💨"
                case .automaticToilet: return "⚡️🚽"
                case .contraception: return "🚫👶"
                default: return nil
                }
            }
        }
    }
    
}
