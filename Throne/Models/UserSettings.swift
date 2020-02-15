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
    private let isLoggedInKey = "is-logged-in"
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoggedInKey)
        }
    }
    
    private let preferredTermKey = "preferred-term"
    var preferredTerm: String {
        get {
            return UserDefaults.standard.string(forKey: preferredTermKey) ?? "washroom"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: preferredTermKey)
        }
    }
    
    private let idTokenKey = "id-token"
    var idToken: String? {
        get {
            return UserDefaults.standard.string(forKey: idTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: idTokenKey)
        }
    }
    
    private let accessTokenKey = "access-token"
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
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
