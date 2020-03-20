//
//  Amenity.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Represent the presents of a specific item in a washroom.
enum Amenity: String, Codable, CaseIterable {
    case airDryer = "air_dryer"
    case paperTowel = "paper_towel"
    
    case automaticDryer = "auto_dryer"
    case automaticPaperTowel = "auto_paper_towel"
    case automaticSink = "auto_sink"
    case automaticToilet = "auto_toilet"
    
    case garbageCan = "garbage_can"
    case coatHook = "coat_hook"
    case fullBodyMirror = "full_body_mirror"
    
    case paperSeatCovers = "paper_seat_covers"
    case tissues = "tissues"
    
    case hygieneProducts = "hygiene_products"
    
    case babyChangeStation = "baby_change_station"
    case diapers = "diapers"
    case babyPowder = "baby_powder"

    case wheelChairAccess = "wheel_chair_access"
    case brailleLabeling = "braille_labeling"
    case callButton = "call_button"
    case safetyRail = "safety_rail"

    case contraception = "contraception"
    case firstAid = "first_aid"
    case needleDisposal = "needle_disposal"
    
    case airFreshener = "air_freshener"
    case lotion = "lotion"
    case perfumeCologne = "perfume_cologne"
    case moistTowelette = "moist_towelette"

    case music = "music"
    case bathroomAttendant = "bathroom_attendant"
    case bidet = "bidet"
    case heatedSeat = "heated_seat"
    case sauna = "sauna"

    case shower = "shower"
    case bodyTowel = "body_towel"
    case shampoo = "shampoo"
    case bodyWash = "bodywash"
    
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
            case .bathroomAttendant: return "Bathroom Attendant"
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
            case .automaticDryer: return "⚡️💨"
            case .automaticSink: return "⚡️🚰"
            case .automaticToilet: return "⚡️🚽"
            case .airDryer: return "💨"
            case .airFreshener: return "🌻"
            case .babyChangeStation: return "👶"
            case .bathroomAttendant: return "🛎"
            case .bidet: return "💦"
            case .bodyTowel: return "🧺"
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
