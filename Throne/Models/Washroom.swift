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
    var comment: String
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
        self.comment = title
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
        
        let shouldUpdateReviewsPublisher = requestReviewsUpdate
            .throttle(for: .seconds(5), scheduler: RunLoop.current, latest: false)
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
            self.objectWillChange.send()
            self.reviewsCount = updatedWashroom.reviewsCount
            self.overallRating = updatedWashroom.overallRating
            self.averageRatings = updatedWashroom.averageRatings
        }
        
        requestReviewsUpdate.send()
    }
    
    func postReview(review: Review) {
        ThroneEndpoint.post(review: review, for: self) { _ in
            self.setupReviewsSubscription()
            self.requestReviewsUpdate.send()
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case comment
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
