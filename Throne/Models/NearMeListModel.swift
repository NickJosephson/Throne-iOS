//
//  NearMeListModel.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

final class NearMeListModel: ObservableObject {    
    private let url = URL(string: "https://api-dev.findmythrone.com/washrooms/")!
    
    init() {
        fetchWashrooms()
    }
    
    @Published var washrooms: [Washroom] = []
    
    private func fetchWashrooms() {
        fetchStrings(at: url) { allWashrooms in
            DispatchQueue.main.async {
                self.washrooms = allWashrooms.map {
                    return Washroom(id: 0, title: $0, location: Location(latitude: 0, longitude: 0), gender: .all, floor: 0, buildingID: 0, createdAt: Date(), overallRating: 0, averageRatings: [:], amenities: [])
                }
            }
        }
    }
}
