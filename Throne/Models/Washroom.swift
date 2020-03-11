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
    var buildingTitle: String
    var additionalTitle: String
    var location: Location
    var distance: Double? // m
    var gender: Gender
    var floor: Int
    var stallsCount: Int
    var urinalsCount: Int
    var buildingID: Int
    var createdAt: Date
    var reviewsCount: Int?
    var overallRating: Double
    var averageRatings: Ratings
    var amenities: [Amenity]
    var isFavorite: Bool
    
    @Published var reviews: [Review] = []
    @Published var favoritingChangeInProgress = false

    var requestReviewsUpdate = PassthroughSubject<Void, Never>()
    private var reviewsSubscription: AnyCancellable!
    private var detailsSubscription: AnyCancellable!

    init(id: Int, buildingTitle: String, additionalTitle: String, location: Location, distance: Double?, gender: Gender, floor: Int, stallsCount: Int, urinalsCount: Int, buildingID: Int, createdAt: Date, reviewsCount: Int?, overallRating: Double, averageRatings: Ratings, amenities: [Amenity], isFavorite: Bool) {
        self.id = id
        self.buildingTitle = buildingTitle
        self.additionalTitle = additionalTitle
        self.location = location
        self.distance = distance
        self.gender = gender
        self.floor = floor
        self.stallsCount = stallsCount
        self.urinalsCount = urinalsCount
        self.buildingID = buildingID
        self.createdAt = createdAt
        self.reviewsCount = reviewsCount
        self.overallRating = overallRating
        self.averageRatings = averageRatings
        self.amenities = amenities
        self.isFavorite = isFavorite
    }
    
    convenience init() {
        self.init(
            id: 0,
            buildingTitle: "",
            additionalTitle: "",
            location: Location(latitude: 0, longitude: 0),
            distance: 0,
            gender: .all,
            floor: 1,
            stallsCount: 1,
            urinalsCount: 0,
            buildingID: 0,
            createdAt: Date(),
            reviewsCount: 0,
            overallRating: 0,
            averageRatings: Ratings(privacy: 0, toiletPaperQuality: 0, smell: 0, cleanliness: 0),
            amenities: [],
            isFavorite: false
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
            self.isFavorite = updatedWashroom.isFavorite
            self.favoritingChangeInProgress = false
        }
        
        requestReviewsUpdate.send()
    }
    
    func updateDetailsFrom(id: Int) {
        ThroneEndpoint.fetchWashroom(matching: id) { newWashroom in
            DispatchQueue.main.async {
                self.objectWillChange.send()
                self.id = newWashroom.id
                self.buildingTitle = newWashroom.buildingTitle
                self.additionalTitle = newWashroom.additionalTitle
                self.location = newWashroom.location
                self.distance = newWashroom.distance
                self.gender = newWashroom.gender
                self.floor = newWashroom.floor
                self.stallsCount = newWashroom.stallsCount
                self.urinalsCount = newWashroom.urinalsCount
                self.buildingID = newWashroom.buildingID
                self.createdAt = newWashroom.createdAt
                self.reviewsCount = newWashroom.reviewsCount
                self.overallRating = newWashroom.overallRating
                self.averageRatings = newWashroom.averageRatings
                self.amenities = newWashroom.amenities
                self.isFavorite = newWashroom.isFavorite
                
                self.requestReviewsUpdate.send()
            }
        }
    }
    
    func postReview(review: Review) {
        ThroneEndpoint.post(review: review, for: self) { _ in
            self.setupReviewsSubscription()
            self.requestReviewsUpdate.send()
            NearMe.shared.requestReviewsUpdate.send()
        }
    }
    
    func toggleIsFavorite() {
        favoritingChangeInProgress = true
        
        if isFavorite {
            ThroneEndpoint.deleteFavorite(washroom: self) {
                self.setupReviewsSubscription()
                self.requestReviewsUpdate.send()
                NearMe.shared.requestFavoritesUpdate.send()
            }
        } else {
            ThroneEndpoint.postFavorite(washroom: self) { _ in
                self.setupReviewsSubscription()
                self.requestReviewsUpdate.send()
                NearMe.shared.requestFavoritesUpdate.send()
            }
        }
    }
    
    var webURL: URL {
        get {
            var url = AppConfiguration.webAddress
            url.appendPathComponent("/washrooms/\(self.id)")
            return url
        }
    }
    
    var distanceDescription: String {
        get {
            if let distance = self.distance {
                if distance < 1000.0 {
                    let value = String(format: "%.0f", distance)
                    return "\(value) m"
                } else {
                    let value = String(format: "%.1f", distance / 1000.0)
                    return "\(value) km"
                }
            } else {
                return "? m"
            }
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case buildingTitle = "building_title"
        case additionalTitle = "comment"
        case location
        case distance
        case gender
        case floor
        case urinalsCount = "urinal_count"
        case stallsCount = "stall_count"
        case buildingID = "building_id"
        case createdAt = "created_at"
        case reviewsCount = "review_count"
        case overallRating = "overall_rating"
        case averageRatings = "average_ratings"
        case amenities
        case isFavorite = "is_favorite"
    }
    
}
