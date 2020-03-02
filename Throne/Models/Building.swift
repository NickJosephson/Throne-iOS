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
    
    @Published var washrooms: [Washroom] = []

    var requestWashroomsUpdate = PassthroughSubject<Void, Never>()
    private var washroomsSubscription: AnyCancellable!
    
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
        
        // create publisher for indicating when to perform near me update
        let locationUpdatePublisher = LocationManager.shared.$currentLocation
            .filter { $0 != nil }
            .map { _ in return }
        let timerUpdatePublisher = Timer.publish(every: TimeInterval(exactly: 300.0)!, on: RunLoop.current, in: .default)
            .autoconnect()
            .map { _ in return }
        let shouldUpdateWashroomsPublisher = timerUpdatePublisher
            .merge(with: locationUpdatePublisher)
            .throttle(for: .seconds(60), scheduler: RunLoop.current, latest: false)
            .merge(with: requestWashroomsUpdate)
            .throttle(for: .seconds(3), scheduler: RunLoop.current, latest: false)
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
        
        requestWashroomsUpdate.send()
    }
    
    func postWashroom(washroom: Washroom) {
        ThroneEndpoint.post(washroom: washroom, for: self) { _ in
            self.setupWashroomsSubscription()
            self.requestWashroomsUpdate.send()
            NearMe.shared.objectWillChange.send()
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
