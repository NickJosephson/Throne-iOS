//
//  UserSettings.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class UserSettings: ObservableObject {

    private let preferredTermKey = "preferred-term"
    var preferredTerm: String {
        get {
            return UserDefaults.standard.string(forKey: preferredTermKey) ?? "washroom"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: preferredTermKey)
        }
    }
    
    private var notificationSubscription: AnyCancellable?

    init() {
        notificationSubscription = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification).sink { _ in
            self.objectWillChange.send()
        }
    }
}

var preferredTermOptions = [
    "john",
    "crapper",
    "latrine",
    "washroom",
    "bathroom",
    "toilet",
    "restroom",
    "lavatory",
    "powder room",
    "comfort station",
    "water closet",
    "privy",
    "loo",
    "can"
]
