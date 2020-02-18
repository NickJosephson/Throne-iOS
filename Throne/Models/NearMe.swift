//
//  NearMe.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

final class NearMe: ObservableObject {
    @Published var washrooms: [Washroom] = []

    init() {
        fetchWashrooms()
    }
    
    private func fetchWashrooms() {
        let location = Location(latitude: 0, longitude: 0)
        
        ThroneEndpoint.fetchWashrooms(near: location) { washrooms in
            DispatchQueue.main.async {
                self.washrooms = washrooms
            }
        }
    }
}
