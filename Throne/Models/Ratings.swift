//
//  Ratings.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

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
