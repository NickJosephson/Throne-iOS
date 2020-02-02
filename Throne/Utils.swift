//
//  Utils.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

/// Fetch Data using a given URL
/// - Parameters:
///   - url: URL it post GET request to
///   - completionHandler: Function to handle Data once received.
func fetch(url: URL, completionHandler: @escaping (Data) -> Void) {
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
            print("Error with fetching: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
        }
        
        if let data = data {
            completionHandler(data)
        }
    })
    
    task.resume()
}

func getAllWashrooms(completionHandler: @escaping ([Washroom]) -> Void) {
    let url = URL(string: "https://api-prod.findmythrone.com/")
    fetch(url: url!) { data in
        if let washrooms = try? JSONDecoder().decode([Washroom].self, from: data) {
            completionHandler(washrooms)
        }
    }
}
