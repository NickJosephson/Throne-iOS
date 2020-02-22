//
//  Review.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Review: Codable {
    let id: Int
    let washroomID: Int
    let userID: Int
    let createdAt: Date
    let upvoteCount: Int
    let ratings: Washroom.Ratings
    let comment: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case washroomID = "washroom_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case upvoteCount = "upvote_count"
        case ratings
        case comment
    }
    
    func getRelativeDateDescription() -> String {
        let df = DateFormatter()
        df.doesRelativeDateFormatting = true
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: self.createdAt)
    }
}
