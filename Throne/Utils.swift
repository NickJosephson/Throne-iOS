//
//  Utils.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine


/// Convenience function to get a list of strings at a given URL
/// - Parameters:
///   - url: URL to GET json list of strings from
///   - completionHandler: Function to handle Strings Array once received
func getAllStrings(at url: URL, completionHandler: @escaping ([String]) -> Void) {
    fetch(url: url) { data in
        if let strings = try? JSONDecoder().decode([String].self, from: data) {
            completionHandler(strings)
        }
    }
}


/// Fetch Data using a given URL
/// - Parameters:
///   - url: URL it post GET request to
///   - completionHandler: Function to handle Data once received.
func fetch(url: URL, completionHandler: @escaping (Data) -> Void) {
    var request = URLRequest(url: url)

    if let accessToken = PersistentSettings().accessToken {
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }

    performRequest(with: request, completionHandler: completionHandler)
}


func performRequest(with request: URLRequest, completionHandler: @escaping (Data) -> Void) {
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error with fetching: \(error)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 401 {
                print("Unauthorized, attempting login refresh.")
                LoginManager.shared.refreshLogin()
                return
            }
        }

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
        }

        if let data = data {
            completionHandler(data)
        }
    }

    task.resume()
}
