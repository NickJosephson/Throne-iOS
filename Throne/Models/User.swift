//
//  User.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Represent a user of Throne.
struct User: Codable {
    let id: Int
    let createdAt: Date?
    let username: String
    let profilePicture: String
    let preferences: User.Preferences?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case username
        case profilePicture = "profile_picture"
        case preferences
    }
    
    struct Preferences: Codable {
        let terminology: String?
    }
}
