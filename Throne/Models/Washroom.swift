//
//  Washroom.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class Washroom: Codable, ObservableObject {
    var id: Int
    var title: String
    var location: Location
    var distance: Double?
    var gender: Gender
    var floor: Int
    var buildingID: Int
    var createdAt: Date
    var reviewsCount: Int?
    var overallRating: Double
    var averageRatings: Ratings
    var amenities: [Amenity]
    
    @Published var reviews: [Review] = []

    var requestReviewsUpdate = PassthroughSubject<Void, Never>()
    private var reviewsSubscription: AnyCancellable!
    private var detailsSubscription: AnyCancellable!

    init(id: Int, title: String, location: Location, distance: Double, gender: Gender, floor: Int, buildingID: Int, createdAt: Date, reviewsCount: Int?, overallRating: Double, averageRatings: Ratings, amenities: [Amenity]) {
        self.id = id
        self.title = title
        self.location = location
        self.distance = distance
        self.gender = gender
        self.floor = floor
        self.buildingID = buildingID
        self.createdAt = createdAt
        self.reviewsCount = reviewsCount
        self.overallRating = overallRating
        self.averageRatings = averageRatings
        self.amenities = amenities
    }
    
    convenience init() {
        self.init(
            id: 0,
            title: "",
            location: Location(latitude: 0, longitude: 0),
            distance: 0.0,
            gender: .all,
            floor: 1,
            buildingID: 0,
            createdAt: Date(),
            reviewsCount: 0,
            overallRating: 0,
            averageRatings: Ratings(privacy: 0, toiletPaperQuality: 0, smell: 0, cleanliness: 0),
            amenities: []
        )
    }
            
    func setupReviewsSubscription() {
        if reviewsSubscription != nil {
            return
        }
        
        // create publisher for indicating when to perform near me update
        let locationUpdatePublisher = LocationManager.shared.$currentLocation
            .filter { $0 != nil }
            .map { _ in return }
        let timerUpdatePublisher = Timer.publish(every: TimeInterval(exactly: 300.0)!, on: RunLoop.current, in: .default)
            .autoconnect()
            .map { _ in return }
        let shouldUpdateReviewsPublisher = timerUpdatePublisher
            .merge(with: locationUpdatePublisher)
            .throttle(for: .seconds(60), scheduler: RunLoop.current, latest: false)
            .merge(with: requestReviewsUpdate)
            .throttle(for: .seconds(3), scheduler: RunLoop.current, latest: false)
            .eraseToAnyPublisher()
        
        reviewsSubscription = shouldUpdateReviewsPublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchReviews(for: self) { reviews in
                        promise(.success(reviews))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.reviews, on: self)
        
        detailsSubscription = shouldUpdateReviewsPublisher
        .flatMap { _ in
            return Future { promise in
                ThroneEndpoint.fetchWashroom(matching: self.id) { washroom in
                    promise(.success(washroom))
                }
            }
        }
        .receive(on: RunLoop.main)
        .sink { updatedWashroom in
            self.reviewsCount = updatedWashroom.reviewsCount
            self.overallRating = updatedWashroom.overallRating
            self.averageRatings = updatedWashroom.averageRatings
            self.objectWillChange.send()
            NearMe.shared.requestDataUpdate.send()
        }
        
        requestReviewsUpdate.send()
    }
    
    func postReview(review: Review) {
        ThroneEndpoint.post(review: review, for: self) { _ in
            self.setupReviewsSubscription()
            self.requestReviewsUpdate.send()
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case distance
        case gender
        case floor
        case buildingID = "building_id"
        case createdAt = "created_at"
        case reviewsCount = "review_count"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
    }
}
