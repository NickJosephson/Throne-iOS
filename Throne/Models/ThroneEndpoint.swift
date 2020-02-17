//
//  ThroneEndpoint.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-17.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Provides interaction with the API interface for Throne
class ThroneEndpoint {
    private static let host = URL(string: "https://api-dev.findmythrone.com")!
    
    class func fetchWashrooms(near location: Location, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms"
        urlComponents.queryItems = [
            URLQueryItem(name: "maxWashrooms", value: "\(100)"),
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "radius", value: "\(100)")
        ]

        print("Fetching washrooms near \(location).")
        fetch(url: urlComponents.url!) { data in
            if let washrooms = try? JSONDecoder().decode([Washroom].self, from: data) {
                completionHandler(washrooms)
            } else {
                print("Error decoding washrooms response.")
            }
        }
    }
    
    class func fetchWashrooms(in building: Building, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(building.id)/washrooms"

        print("Fetching washrooms in \(building.title).")
        fetch(url: urlComponents.url!) { data in
            if let washrooms = try? JSONDecoder().decode([Washroom].self, from: data) {
                completionHandler(washrooms)
            } else {
                print("Error decoding washrooms response.")
            }
        }
    }
    
    class func fetchWashrooms(favoritedBy user: User, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(user.id)/favorites"

        print("Fetching washrooms favorited by \(user.username).")
        fetch(url: urlComponents.url!) { data in
            if let washrooms = try? JSONDecoder().decode([Washroom].self, from: data) {
                completionHandler(washrooms)
            } else {
                print("Error decoding washrooms response.")
            }
        }
    }
    
    class func fetchWashroom(matching id: Int, completionHandler: @escaping (Washroom) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(id)"

        print("Fetching washroom matching \(id).")
        fetch(url: urlComponents.url!) { data in
            if let washroom = try? JSONDecoder().decode(Washroom.self, from: data) {
                completionHandler(washroom)
            } else {
                print("Error decoding washroom response.")
            }
        }
    }

    class func fetchBuildings(near location: Location, completionHandler: @escaping ([Building]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings"
        urlComponents.queryItems = [
            URLQueryItem(name: "maxWashrooms", value: "\(100)"),
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "radius", value: "\(100)")
        ]

        print("Fetching Buildings near \(location).")
        fetch(url: urlComponents.url!) { data in
            if let buildings = try? JSONDecoder().decode([Building].self, from: data) {
                completionHandler(buildings)
            } else {
                print("Error decoding buildings response.")
            }
        }
    }
    
    class func fetchBuilding(matching id: Int, completionHandler: @escaping (Building) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(id)"

        print("Fetching building matching \(id).")
        fetch(url: urlComponents.url!) { data in
            if let building = try? JSONDecoder().decode(Building.self, from: data) {
                completionHandler(building)
            } else {
                print("Error decoding building response.")
            }
        }
    }
    
    class func fetchReviews(for washroom: Washroom, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(washroom.id)/reviews"

        print("Fetching reviews for \(washroom.title).")
        fetch(url: urlComponents.url!) { data in
            if let reviews = try? JSONDecoder().decode([Review].self, from: data) {
                completionHandler(reviews)
            } else {
                print("Error decoding reviews response.")
            }
        }
    }
    
    class func fetchReviews(madeBy user: User, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(user.id)/reviews"

        print("Fetching reviews made by \(user.username).")
        fetch(url: urlComponents.url!) { data in
            if let reviews = try? JSONDecoder().decode([Review].self, from: data) {
                completionHandler(reviews)
            } else {
                print("Error decoding reviews response.")
            }
        }
    }
    
    class func fetchReview(matching id: Int, completionHandler: @escaping (Review) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/reviews/\(id)"

        print("Fetching review matching \(id).")
        fetch(url: urlComponents.url!) { data in
            if let review = try? JSONDecoder().decode(Review.self, from: data) {
                completionHandler(review)
            } else {
                print("Error decoding review response.")
            }
        }
    }
    
    class func fetchUser(matching id: Int, completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(id)"

        print("Fetching user matching \(id).")
        fetch(url: urlComponents.url!) { data in
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                completionHandler(user)
            } else {
                print("Error decoding user response.")
            }
        }
    }
    
    class func fetchCurrentUser(completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/user"

        print("Fetching current user.")
        fetch(url: urlComponents.url!) { data in
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                completionHandler(user)
            } else {
                print("Error decoding user response.")
            }
        }
    }
    
}
