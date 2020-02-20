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
    private static let host = AppConfiguration.apiAddress
    
    class func fetchWashrooms(near location: Location, maxResults: Int = 100,completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/"
        urlComponents.queryItems = [
            URLQueryItem(name: "max_results", value: "\(maxResults)"),
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "radius", value: "\(location.radius)")
        ]

        print("Fetching washrooms near \(location).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchWashrooms(in building: Building, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(building.id)/washrooms/"

        print("Fetching washrooms in \(building.title).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchWashrooms(favoritedBy user: User, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(user.id)/favorites/"

        print("Fetching washrooms favorited by \(user.username).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchWashroom(matching id: Int, completionHandler: @escaping (Washroom) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(id)/"

        print("Fetching washroom matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }

    class func fetchBuildings(near location: Location, maxResults: Int = 100, completionHandler: @escaping ([Building]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/"
        urlComponents.queryItems = [
            URLQueryItem(name: "max_results", value: "\(maxResults)"),
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "radius", value: "\(location.radius)")
        ]

        print("Fetching Buildings near \(location).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchBuilding(matching id: Int, completionHandler: @escaping (Building) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(id)/"

        print("Fetching building matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReviews(for washroom: Washroom, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(washroom.id)/reviews/"

        print("Fetching reviews for \(washroom.title).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReviews(madeBy user: User, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(user.id)/reviews/"

        print("Fetching reviews made by \(user.username).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReview(matching id: Int, completionHandler: @escaping (Review) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/reviews/\(id)/"

        print("Fetching review matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchUser(matching id: Int, completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(id)/"

        print("Fetching user matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchCurrentUser(completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/user/"

        print("Fetching current user.")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    private class func fetchAndDecode<T: Decodable>(url: URL, completionHandler: @escaping (T) -> Void) {
        fetch(url: url) { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                let decoded: T
                
                try decoded = decoder.decode(T.self, from: data)
                
                completionHandler(decoded)
            } catch DecodingError.dataCorrupted {
                print("Error decoding response: Data is corrupted or invalid.")
            } catch let DecodingError.keyNotFound(key, _) {
                print("Error decoding response: Key '\(key)' not found.")
            } catch let DecodingError.valueNotFound(value, _) {
                print("Error decoding response: Value '\(value)' not found.")
            } catch let DecodingError.typeMismatch(type, _)  {
                print("Error decoding response: Type '\(type)' mismatch.")
            } catch {
                print("Error decoding response.")
            }
        }
    }
    
}
