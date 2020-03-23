//
//  Washroom.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

/// Model a washroom and keep an up to date list of its reviews.
final class Washroom: Codable, ObservableObject, Hashable {
    var id: Int
    var buildingTitle: String
    var additionalTitle: String
    var location: Location
    var distance: Double? // kilometers
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
                    ThroneEndpoint.shared.fetchReviews(for: self) { reviews in
                        promise(.success(reviews))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.reviews, on: self)
        
        detailsSubscription = shouldUpdateReviewsPublisher
        .flatMap { _ in
            return Future { promise in
                ThroneEndpoint.shared.fetchWashroom(matching: self.id) { washroom in
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
    
    /// Update the details of this washroom from the Throne endpoint.
    /// - Parameter id: ID of the washroom to fetch details for.
    func updateDetailsFrom(id: Int) {
        ThroneEndpoint.shared.fetchWashroom(matching: id) { newWashroom in
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
    
    /// Add a new review to this washroom.
    /// - Parameter review: The new review to add.
    func postReview(review: Review) {
        ThroneEndpoint.shared.post(review: review, for: self) { _ in
            self.setupReviewsSubscription()
            self.requestReviewsUpdate.send()
            NearMe.shared.requestReviewsUpdate.send()
        }
    }
    
    /// Favorite or Unfavorite this washroom.
    func toggleIsFavorite() {
        favoritingChangeInProgress = true
        
        if isFavorite {
            ThroneEndpoint.shared.deleteFavorite(washroom: self) {
                self.setupReviewsSubscription()
                self.requestReviewsUpdate.send()
                NearMe.shared.requestFavoritesUpdate.send()
            }
        } else {
            ThroneEndpoint.shared.postFavorite(washroom: self) { _ in
                self.setupReviewsSubscription()
                self.requestReviewsUpdate.send()
                NearMe.shared.requestFavoritesUpdate.send()
            }
        }
    }
    
    /// A URL to the website for this washroom.
    var webURL: URL {
        get {
            var url = AppConfiguration.webAddress
            url.appendPathComponent("/washrooms/\(self.id)")
            return url
        }
    }
    
    /// A human readable description of the distance to this washroom.
    var distanceDescription: String {
        get {
            if let distance = self.distance {
                if distance < 1.0 {
                    let value = String(format: "%.0f", distance * 1000.0)
                    return "\(value) m"
                } else {
                    let value = String(format: "%.1f", distance)
                    return "\(value) km"
                }
            } else {
                return "? m"
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(buildingID)
    }
    
    static func == (lhs: Washroom, rhs: Washroom) -> Bool {
        return lhs.id == rhs.id && lhs.buildingID == rhs.buildingID
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
