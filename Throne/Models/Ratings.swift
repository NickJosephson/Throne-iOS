//
//  Ratings.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Ratings: Codable {
    var privacy = 0.0
    var toiletPaperQuality = 0.0
    var smell = 0.0
    var cleanliness = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case privacy
        case toiletPaperQuality = "toilet_paper_quality"
        case smell
        case cleanliness
    }
    
}
