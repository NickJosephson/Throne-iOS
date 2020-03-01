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
        case reviewsCount = "review_count"
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
                case .airDryer: return "Air Dryer"
                case .airFreshener: return "Air Freshener"
                case .automaticDryer: return "Automatic Dryer"
                case .automaticPaperTowel: return "Automatic Paper Towel"
                case .automaticSink: return "Automatic Sink"
                case .automaticToilet: return "Automatic Toilet"
                case .babyChangeStation: return "Baby Change Station"
                case .babyPowder: return "Baby Powder"
                case .bathroomAttendant: return "Bathroom Attendant "
                case .bidet: return "Bidet"
                case .bodyTowel: return "Body Towel"
                case .bodyWash: return "Body Wash"
                case .brailleLabeling: return "Braille Labeling"
                case .callButton: return "Call Button"
                case .coatHook: return "Coat Hook"
                case .contraception: return "Contraception"
                case .diapers: return "Diapers"
                case .hygieneProducts: return "Hygiene Products"
                case .firstAid: return "First Aid"
                case .fullBodyMirror: return "Full Body Mirror"
                case .garbageCan: return "Garbage Can"
                case .heatedSeat: return "Heated Seat"
                case .lotion: return "Lotion"
                case .moistTowelette: return "Moist Towelette"
                case .music: return "Music"
                case .needleDisposal: return "Needle Disposal"
                case .paperSeatCovers: return "Paper Seat Covers"
                case .paperTowel: return "Paper Towel"
                case .perfumeCologne: return "Perfume Cologne"
                case .safetyRail: return "Safety Rail"
                case .sauna: return "Sauna"
                case .shampoo: return "Shampoo"
                case .shower: return "Shower"
                case .tissues: return "Tissues"
                case .wheelChairAccess: return "Wheel Chair Access"
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
                 case .bidet: return "💦"
                 case .bodyTowel: return "🧺"
                 case .brailleLabeling: return "⠞⠗⠝"
                 case .callButton: return "📢"
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
                 case .sauna: return "🧖🏽‍♂️"
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
