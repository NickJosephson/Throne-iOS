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
        case airDryer = "air_dryer"
        case airFreshener = "air_freshener"
        case automaticDryer = "auto_dryer"
        case automaticPaperTowel = "auto_paper_towel"
        case automaticSink = "auto_sink"
        case automaticToilet = "auto_toilet"
        case babyChangeStation = "baby_change_station"
        case babyPowder = "baby_powder"
        case bathroomAttendant = "bathroom_attendant "
        case bidet = "bidet"
        case bodyTowel = "body_towel"
        case bodyWash = "bodywash"
        case brailleLabeling = "braille_labeling"
        case callButton = "call_button"
        case coatHook = "coat_hook"
        case contraception = "contraception"
        case diapers = "diapers"
        case hygieneProducts = "hygiene_products"
        case firstAid = "first_aid"
        case fullBodyMirror = "full_body_mirror"
        case garbageCan = "garbage_can"
        case heatedSeat = "heated_seat"
        case lotion = "lotion"
        case moistTowelette = "moist_towelette"
        case music = "music"
        case needleDisposal = "needle_disposal"
        case paperSeatCovers = "paper_seat_covers"
        case paperTowel = "paper_towel"
        case perfumeCologne = "perfume_cologne"
        case safetyRail = "safety_rail"
        case sauna = "sauna"
        case shampoo = "shampoo"
        case shower = "shower"
        case tissues = "tissues"
        case wheelChairAccess = "wheel_chair_access"

        var description: String {
            get {
                switch self {
                case .airDryer: return "air_dryer"
                case .airFreshener: return "air_freshener"
                case .automaticDryer: return "auto_dryer"
                case .automaticPaperTowel: return "auto_paper_towel"
                case .automaticSink: return "auto_sink"
                case .automaticToilet: return "auto_toilet"
                case .babyChangeStation: return "baby_change_station"
                case .babyPowder: return "baby_powder"
                case .bathroomAttendant: return "bathroom_attendant "
                case .bidet: return "bidet"
                case .bodyTowel: return "body_towel"
                case .bodyWash: return "bodywash"
                case .brailleLabeling: return "braille_labeling"
                case .callButton: return "call_button"
                case .coatHook: return "coat_hook"
                case .contraception: return "contraception"
                case .diapers: return "diapers"
                case .hygieneProducts: return "hygiene_products"
                case .firstAid: return "first_aid"
                case .fullBodyMirror: return "full_body_mirror"
                case .garbageCan: return "garbage_can"
                case .heatedSeat: return "heated_seat"
                case .lotion: return "lotion"
                case .moistTowelette: return "moist_towelette"
                case .music: return "music"
                case .needleDisposal: return "needle_disposal"
                case .paperSeatCovers: return "paper_seat_covers"
                case .paperTowel: return "paper_towel"
                case .perfumeCologne: return "perfume_cologne"
                case .safetyRail: return "safety_rail"
                case .sauna: return "sauna"
                case .shampoo: return "shampoo"
                case .shower: return "shower"
                case .tissues: return "tissues"
                case .wheelChairAccess: return "wheel_chair_access"
                }
            }
        }

        var emoji: String? {
             get {
                 switch self {
                 case .airDryer: return "💨"
                 case .airFreshener: return "🌻"
                 case .automaticDryer: return "⚡️💨"
                 case .automaticSink: return "⚡️🚰"
                 case .automaticToilet: return "⚡️🚽"
                 case .babyChangeStation: return "👶"
                 case .bathroomAttendant: return "🛎 "
                 case .brailleLabeling: return "⠞⠗⠝"
                 case .callButton: return "📢"
                 case .coatHook: return "coat_hook"
                 case .contraception: return "🚫👶"
                 case .diapers: return "🧷"
                 case .hygieneProducts: return "♀"
                 case .firstAid: return "🩹"
                 case .garbageCan: return "🗑"
                 case .heatedSeat: return "🔥🚽"
                 case .lotion: return "🧴"
                 case .music: return "🎶"
                 case .needleDisposal: return "💉"
                 case .perfumeCologne: return "🌹"
                 case .shampoo: return "🧴💆‍♀️"
                 case .shower: return "🚿"
                 case .tissues: return "🤧"
                 case .wheelChairAccess: return "♿️"
                 default: return nil
                 }
             }
         }
    }
    
}
