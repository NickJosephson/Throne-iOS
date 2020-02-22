//
//  Reviews.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

final class Reviews: ObservableObject {
    @Published var reviews: [Review] = []
    private var washroom: Washroom
    
    init(for washroom: Washroom) {
        self.washroom = washroom
        
        fetchReviews()
    }
    
    private func fetchReviews() {
        ThroneEndpoint.fetchReviews(for: self.washroom) { reviews in
            DispatchQueue.main.async {
                self.reviews = reviews
            }
        }
    }
}
