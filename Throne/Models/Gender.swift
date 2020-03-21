//
//  Gender.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Represent the specified gender of a washroom.
enum Gender: String, Codable, CaseIterable {
    case all
    case women
    case men

    var description: String {
        get {
            switch self {
            case .all: return "Inclusive"
            case .women: return "Women's"
            case .men: return "Men's"
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
