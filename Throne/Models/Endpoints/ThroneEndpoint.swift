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
    
    class func fetchWashrooms(near location: Location?, maxResults: Int = 100, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/"
        urlComponents.queryItems = [
            URLQueryItem(name: "max_results", value: "\(maxResults)"),
        ]
        if location != nil {
            urlComponents.queryItems!.append(contentsOf: [
                URLQueryItem(name: "latitude", value: "\(location!.latitude)"),
                URLQueryItem(name: "longitude", value: "\(location!.longitude)"),
                URLQueryItem(name: "radius", value: "\(location!.radius)")
            ])
        }

        NSLog("Fetching washrooms near \(String(describing: location)).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchWashrooms(in building: Building, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(building.id)/washrooms/"

        NSLog("Fetching washrooms in \(building.title).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
        
    class func fetchWashroom(matching id: Int, completionHandler: @escaping (Washroom) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(id)/"

        NSLog("Fetching washroom matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }

    class func fetchBuildings(near location: Location?, maxResults: Int = 10000, completionHandler: @escaping ([Building]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/"
        urlComponents.queryItems = [
            URLQueryItem(name: "max_results", value: "\(maxResults)"),
        ]
        if location != nil {
            urlComponents.queryItems!.append(contentsOf: [
                URLQueryItem(name: "latitude", value: "\(location!.latitude)"),
                URLQueryItem(name: "longitude", value: "\(location!.longitude)"),
                URLQueryItem(name: "radius", value: "\(location!.radius)")
            ])
        }

        NSLog("Fetching buildings near \(String(describing: location)).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchBuilding(matching id: Int, completionHandler: @escaping (Building) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/buildings/\(id)/"

        NSLog("Fetching building matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReviews(for washroom: Washroom, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(washroom.id)/reviews/"

        NSLog("Fetching reviews for washroom \(washroom.id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReviews(madeBy user: User, completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(user.id)/reviews/"

        NSLog("Fetching reviews made by \(user.username).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReviews(completionHandler: @escaping ([Review]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/reviews/"

        NSLog("Fetching reviews made by current user.")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchReview(matching id: Int, completionHandler: @escaping (Review) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/reviews/\(id)/"

        NSLog("Fetching review matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchUser(matching id: Int, completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/\(id)/"

        NSLog("Fetching user matching \(id).")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func fetchCurrentUser(completionHandler: @escaping (User) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/"

        NSLog("Fetching current user.")
        fetchAndDecode(url: urlComponents.url!, completionHandler: completionHandler)
    }
    
    class func post(review: Review, for washroom: Washroom, completionHandler: @escaping (Review) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/\(washroom.id)/reviews/"

        NSLog("Posting review for washroom \(washroom.id).")
        encodeAndPost(url: urlComponents.url!, item: review, completionHandler: completionHandler)
    }
    
    class func post(washroom: Washroom, for building: Building, completionHandler: @escaping (Washroom) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/washrooms/"

        NSLog("Posting washroom for \(building.title).")
        encodeAndPost(url: urlComponents.url!, item: washroom, completionHandler: completionHandler)
    }
    
    class func postFavorite(washroom: Washroom, completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/favorites"
        
        NSLog("Posting washroom \(washroom.id) as favorite.")
        encodeAndPost(url: urlComponents.url!, item: washroom, completionHandler: completionHandler)
    }
    
    class func deleteFavorite(washroom: Washroom, completionHandler: @escaping () -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/favorites"
        
        NSLog("Deleting washroom \(washroom.id) as favorite.")
        encodeAndPost(url: urlComponents.url!, item: washroom, method: "DELETE", completionHandler: completionHandler)
    }

    class func fetchFavorites(completionHandler: @escaping ([Washroom]) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/users/favorites/"

        NSLog("Fetching favorite washrooms.")
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
                NSLog("Error decoding response: Data is corrupted or invalid.")
            } catch let DecodingError.keyNotFound(key, _) {
                NSLog("Error decoding response: Key '\(key)' not found.")
            } catch let DecodingError.valueNotFound(value, _) {
                NSLog("Error decoding response: Value '\(value)' not found.")
            } catch let DecodingError.typeMismatch(type, _)  {
                NSLog("Error decoding response: Type '\(type)' mismatch.")
            } catch {
                NSLog("Error decoding response.")
            }
        }
    }
    
    private class func encodeAndPost<Body: Encodable>(url: URL, item: Body, method: String = "POST", completionHandler: @escaping () -> Void) {
        let data: Data

        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601

            data = try encoder.encode(item)
        } catch {
            NSLog("Error encoding response.")
            return
        }

        post(url: url, data: data, method: method) { _ in
            completionHandler()
        }
    }
    
    private class func encodeAndPost<Body: Encodable, Response: Decodable>(url: URL, item: Body, method: String = "POST", completionHandler: @escaping (Response) -> Void) {
        let data: Data
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            data = try encoder.encode(item)
        } catch {
            NSLog("Error encoding response.")
            return
        }
        
        post(url: url, data: data) { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
                let decoded: Response
                
                try decoded = decoder.decode(Response.self, from: data)
                
                completionHandler(decoded)
            } catch DecodingError.dataCorrupted {
                NSLog("Error decoding response: Data is corrupted or invalid.")
            } catch let DecodingError.keyNotFound(key, _) {
                NSLog("Error decoding response: Key '\(key)' not found.")
            } catch let DecodingError.valueNotFound(value, _) {
                NSLog("Error decoding response: Value '\(value)' not found.")
            } catch let DecodingError.typeMismatch(type, _)  {
                NSLog("Error decoding response: Type '\(type)' mismatch.")
            } catch {
                NSLog("Error decoding response.")
            }
        }
    }
    
    /// Post Data at a given URL.
    ///
    /// If an accessToken is set it will be used for authentication.
    /// - Parameters:
    ///   - url: URL to send GET request to.
    ///   - completionHandler: Function to handle Data once received.
    private class func post(url: URL, data: Data, method: String = "POST", completionHandler: @escaping (Data) -> Void) {
        if !LoginManager.shared.isLoggedIn {
            NSLog("Throne Endpoint Post Cancelled: Not logged in.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        if let accessToken = PersistentSettings.shared.accessToken, !accessToken.isEmpty {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        performRequest(with: request, completionHandler: completionHandler)
    }
    
    /// Fetch Data at a given URL.
    ///
    /// If an accessToken is set it will be used for authentication.
    /// - Parameters:
    ///   - url: URL to send GET request to.
    ///   - completionHandler: Function to handle Data once received.
    private class func fetch(url: URL, completionHandler: @escaping (Data) -> Void) {
        if !LoginManager.shared.isLoggedIn {
            NSLog("Throne Endpoint Fetch Cancelled: Not logged in.")
            return
        }
        
        var request = URLRequest(url: url)

        if let accessToken = PersistentSettings.shared.accessToken, !accessToken.isEmpty {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        performRequest(with: request, completionHandler: completionHandler)
    }

    /// Perform a URLRequest with error handling.
    /// - Parameters:
    ///   - request: URLRequest to perform.
    ///   - completionHandler: Function to handle Data once received.
    private class func performRequest(with request: URLRequest, completionHandler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Throne Endpoint URL Session Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    NSLog("Throne Endpoint URL Session Error: Unauthorized, requesting login refresh.")
                    LoginManager.shared.requestRefresh.send()
                    return
                } else if !(200...299).contains(httpResponse.statusCode) {
                    NSLog("Throne Endpoint URL Session Error: Unexpected status code \(httpResponse.statusCode))")
                    return
                }
            }

            if let data = data {
                completionHandler(data)
            }
        }

        task.resume()
    }
}
