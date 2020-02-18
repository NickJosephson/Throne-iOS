//
//  Location.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-10.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let radius: Int = 1000 // meters
}
