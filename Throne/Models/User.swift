//
//  User.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let createdAt: Date
    let profilePicture: URL
    let settings: User.Settings
    let preferences: User.Preferences
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case profilePicture = "profile_picture"
        case settings
        case preferences = "washroom_preferences"
    }
    
    struct Settings: Codable {
        let terminology: String?
    }
    
    struct Preferences: Codable {
        let gender: Washroom.Gender?
    }
}
