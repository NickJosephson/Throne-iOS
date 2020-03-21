//
//  ThroneEndpointStub.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-20.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

class ThroneEndpointStub: ThroneEndpoint {
    private static func generateBuildingsAndWashrooms() -> ([Building], [Washroom]) {
        var buildings = [Building]()
        var washrooms = [Washroom]()
        var currentWashroomID = 0
        
        for buildingID in 0..<10 {
            let newBuilding = Building()
            newBuilding.id = buildingID
            newBuilding.title = "Building \(buildingID)"
            
            for washroomFloor in 0..<5 {
                let newWashroom = Washroom()
                newWashroom.id = currentWashroomID
                newWashroom.buildingID = buildingID
                newWashroom.floor = washroomFloor
                newWashroom.buildingTitle = newBuilding.title
                washrooms.append(newWashroom)
                newBuilding.washrooms.append(newWashroom)
                currentWashroomID += 1
            }
            
            newBuilding.washroomsCount = newBuilding.washrooms.count
            buildings.append(newBuilding)
        }
        
        return (buildings, washrooms)
    }
    
    var washrooms: [Washroom] = {
        return generateBuildingsAndWashrooms().1
    }()
    
    var buildings: [Building] = {
        return generateBuildingsAndWashrooms().0
    }()
    
    var favorites: [Washroom] = []
    var reviews: [Review] = []
    var currentUser = User(id: 0, createdAt: Date(), username: "Username", profilePicture: "", preferences: nil)
    
    override func fetchWashrooms(near location: Location?, filteredBy filter: Filter? = nil, maxResults: Int = 1000, completionHandler: @escaping ([Washroom]) -> Void) {
        completionHandler([Washroom](washrooms.prefix(maxResults)))
    }

    override func fetchWashrooms(in building: Building, completionHandler: @escaping ([Washroom]) -> Void) {
        completionHandler(building.washrooms)
    }

    override func fetchWashroom(matching id: Int, completionHandler: @escaping (Washroom) -> Void) {
        completionHandler(washrooms.first(where: { $0.id == id })!)
    }

    override func fetchBuildings(near location: Location?, filteredBy filter: Filter? = nil, maxResults: Int = 1000, completionHandler: @escaping ([Building]) -> Void) {
        completionHandler([Building](buildings.prefix(maxResults)))
    }

    override func fetchBuilding(matching id: Int, completionHandler: @escaping (Building) -> Void) {
        completionHandler(buildings.first(where: { $0.id == id })!)
    }

    override func fetchReviews(for washroom: Washroom, completionHandler: @escaping ([Review]) -> Void) {
        completionHandler(washroom.reviews)
    }

    override func fetchReviews(madeBy user: User, completionHandler: @escaping ([Review]) -> Void) {
        completionHandler(reviews)
    }

    override func fetchReviews(completionHandler: @escaping ([Review]) -> Void) {
        completionHandler(reviews)
    }

    override func fetchReview(matching id: Int, completionHandler: @escaping (Review) -> Void) {
        completionHandler(reviews.first(where: { $0.id == id })!)
    }

    override func fetchUser(matching id: Int, completionHandler: @escaping (User) -> Void) {
        completionHandler(currentUser)
    }

    override func fetchCurrentUser(completionHandler: @escaping (User) -> Void) {
        completionHandler(currentUser)
    }

    override func post(review: Review, for washroom: Washroom, completionHandler: @escaping (Review) -> Void) {
        var newReview = review
        newReview.id = (reviews.last?.id ?? -1) + 1

        washroom.reviews.append(review)
        washroom.reviewsCount = (washroom.reviewsCount ?? 0) + 1
        reviews.append(review)
        completionHandler(review)
    }

    override func post(washroom: Washroom, for building: Building, completionHandler: @escaping (Washroom) -> Void) {
        building.washrooms.append(washroom)
        washroom.id = (washrooms.last?.id ?? -1) + 1
        washrooms.append(washroom)
        completionHandler(washroom)
    }

    override func postFavorite(washroom: Washroom, completionHandler: @escaping ([Washroom]) -> Void) {
        favorites.append(washroom)
        washroom.isFavorite = true
        completionHandler(favorites)
    }

    override func deleteFavorite(washroom: Washroom, completionHandler: @escaping () -> Void) {
        favorites.removeAll(where: { $0 == washroom })
        washroom.isFavorite = false
        completionHandler()
    }

    override func fetchFavorites(completionHandler: @escaping ([Washroom]) -> Void) {
        completionHandler(favorites)
    }

}

