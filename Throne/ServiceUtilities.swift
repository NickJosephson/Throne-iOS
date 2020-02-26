//
//  ServiceUtilities.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Fetch a list of strings at a given URL.
/// - Parameters:
///   - url: URL to GET json list of strings from.
///   - completionHandler: Function to handle Strings Array once received.
func fetchStrings(at url: URL, completionHandler: @escaping ([String]) -> Void) {
    fetch(url: url) { data in
        if let strings = try? JSONDecoder().decode([String].self, from: data) {
            completionHandler(strings)
        }
    }
}

/// Fetch Data at a given URL.
///
/// If an accessToken is set it will be used for authentication.
/// - Parameters:
///   - url: URL to send GET request to.
///   - completionHandler: Function to handle Data once received.
func fetch(url: URL, completionHandler: @escaping (Data) -> Void) {
    var request = URLRequest(url: url)

    if let accessToken = PersistentSettings().accessToken {
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }

    performRequest(with: request, completionHandler: completionHandler)
}

/// Perform a URLRequest with error handling.
/// - Parameters:
///   - request: URLRequest to perform.
///   - completionHandler: Function to handle Data once received.
func performRequest(with request: URLRequest, completionHandler: @escaping (Data) -> Void) {
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            NSLog("Fetching error: \(error)")
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 401 {
                NSLog("Fetching error: Unauthorized, attempting login refresh.")
                LoginManager.shared.refreshLogin()
                return
            }
        }

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            NSLog("Fetching error: Unexpected status code: \(String(describing: response))")
            return
        }

        if let data = data {
            completionHandler(data)
        }
    }

    task.resume()
}
