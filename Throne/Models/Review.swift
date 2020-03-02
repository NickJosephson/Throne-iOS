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
    let user: User!
    let createdAt: Date
    let upvoteCount: Int?
    let ratings: Ratings
    let comment: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case washroomID = "washroom_id"
        case user
        case createdAt = "created_at"
        case upvoteCount = "upvote_count"
        case ratings
        case comment
    }
    
    func getRelativeDateDescription() -> String {
        let df = DateFormatter()
        df.doesRelativeDateFormatting = true
        df.dateStyle = .medium
        df.timeStyle = .none
        return df.string(from: self.createdAt)
    }
}
