//
//  Review.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Review: Codable, Hashable {
    let id: Int
    let washroomID: Int
    let user: User?
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
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id && lhs.washroomID == rhs.washroomID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(washroomID)
        hasher.combine(createdAt)
    }
    
}

extension Review {
    init(ratings: Ratings, comment: String) {
        self.init(
            id: 0,
            washroomID: 0,
            user: nil,
            createdAt: Date(),
            upvoteCount: 0,
            ratings: ratings,
            comment: comment
        )
    }
    
    init() {
        self.init(
            id: 0,
            washroomID: 0,
            user: nil,
            createdAt: Date(),
            upvoteCount: 0,
            ratings: Ratings(privacy: 0, toiletPaperQuality: 0, smell: 0, cleanliness: 0),
            comment: ""
        )
    }
}
