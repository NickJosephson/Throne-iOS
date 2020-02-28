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
        case reviewsCount = "reviews_count"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
    }
    
    enum Gender: String, Codable, CaseIterable {
        case all
        case women
        case men
        case family

        var description: String {
            get {
                switch self {
                case .all: return "Inclusive"
                case .women: return "Women's"
                case .men: return "Men's"
                case .family: return "Family"
                }
            }
        }
        
        var emoji: String {
            get {
                switch self {
                case .women: return "🚺"
                case .men: return "🚹"
                case .all: return "🚻"
                case .family: return "🚻"
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
    
    enum Amenity: String, Codable, CaseIterable {
        case wheelchairAccessible = "Wheelchair Accessible"
        case babyChangeStation = "Baby Changing Station"
        case hygieneProducts = "Hygiene Products"
        case paperSeatCover = "Paper Seat Covers"
        case automaticSink = "Automatic Sink"
        case automaticToilet = "Automatic Toilet"
        case automaticDryer = "Automatic Dryer"
        case automaticPaperTowel = "Automatic Paper Towel"
        case airDryer = "Air Dryer"
        case paperTowel = "Paper Towel"
        case shower = "Shower"
        case soap = "Soap"
        case attendant = "Bathroom Attendant"
        case urinal = "Urinal"
        case contraception = "Contraception"
        case lotion = "Lotion"
        case needleDisposal = "Needle Disposal"
        case perfume = "Perfume/Cologne"
        
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
                case .automaticSink: return "⚡️🚰"
                case .automaticDryer: return "⚡️💨"
                case .wheelchairAccessible: return "♿️"
                case .contraception: return "🚫👶"
                default: return nil
                }
            }
        }
    }
    
}
