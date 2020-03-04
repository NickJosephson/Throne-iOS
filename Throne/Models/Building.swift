//
//  Building.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class Building: Codable, ObservableObject {
    var id: Int
    var title: String
    var location: Location
    var distance: Double?
    var createdAt: Date
    var overallRating: Double
    var bestRatings: Ratings
    
    @Published var washrooms: [Washroom] = [] {
        didSet {
            var subscriptions: [AnyCancellable] = []
            for washroom in washrooms {
                let subscription = washroom.objectWillChange
                    .sink {
                        self.requestDetailsUpdate.send()
                    }
                subscriptions.append(subscription)
            }
            self.washroomsIndividualSubscriptions = subscriptions
        }
    }

    var requestWashroomsUpdate = PassthroughSubject<Void, Never>()
    var requestDetailsUpdate = PassthroughSubject<Void, Never>()
    private var washroomsSubscription: AnyCancellable!
    private var detailsSubscription: AnyCancellable!
    private var washroomsIndividualSubscriptions: [AnyCancellable] = []
    
    init(id: Int, title: String, location: Location, distance: Double, createdAt: Date, overallRating: Double, bestRatings: Ratings) {
        self.id = id
        self.title = title
        self.location = location
        self.distance = distance
        self.createdAt = createdAt
        self.overallRating = overallRating
        self.bestRatings = bestRatings
    }
    
    convenience init() {
        self.init(
            id: 0,
            title: "",
            location: Location(latitude: 0, longitude: 0),
            distance: 0,
            createdAt: Date(),
            overallRating: 0,
            bestRatings: Ratings(privacy: 0, toiletPaperQuality: 0, smell: 0, cleanliness: 0)
        )
    }
    
    func setupWashroomsSubscription() {
        if washroomsSubscription != nil {
            return
        }
        
        let shouldUpdateWashroomsPublisher = requestWashroomsUpdate
            .throttle(for: .seconds(5), scheduler: RunLoop.current, latest: false)
            .eraseToAnyPublisher()
        
        washroomsSubscription = shouldUpdateWashroomsPublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchWashrooms(in: self) { washrooms in
                        promise(.success(washrooms))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.washrooms, on: self)
                
        detailsSubscription = requestDetailsUpdate
            .merge(with: shouldUpdateWashroomsPublisher)
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchBuilding(matching: self.id) { building in
                        promise(.success(building))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .sink { updatedBuilding in
                self.objectWillChange.send()
                self.overallRating = updatedBuilding.overallRating
                self.bestRatings = updatedBuilding.bestRatings
            }
        
        self.requestWashroomsUpdate.send()
    }
    
    func postWashroom(washroom: Washroom) {
        ThroneEndpoint.post(washroom: washroom, for: self) { _ in
            self.setupWashroomsSubscription()
            self.requestWashroomsUpdate.send()
        }
    }
    
    var distanceDescription: String {
        get {
            if let distance = self.distance {
                if distance < 500.0 {
                    let value = String(format: "%.1f", distance)
                    return "\(value) m"
                } else {
                    let value = String(format: "%.1f", distance / 1000.0)
                    return "\(value) km"
                }
            } else {
                return "?m"
            }
        }
    }

    var stars: String {
        get {
            if self.overallRating <= 0 {
                return ""
            }
            
            var stars = ""
            for rating in 1...5 {
                if Double(rating) > self.overallRating.rounded(.toNearestOrAwayFromZero) {
                    stars += "☆"
                } else {
                    stars += "★"
                }
            }
            return stars
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case distance
        case createdAt = "created_at"
        case overallRating = "overall_rating"
        case bestRatings = "best_ratings"
    }
    
}
