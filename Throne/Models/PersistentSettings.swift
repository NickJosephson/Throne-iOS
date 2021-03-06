//
//  PersistentSettings.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

/// Observable Key-Value storage for persistence of key application settings.
final class PersistentSettings: ObservableObject {
    static var shared = PersistentSettings() // Shared instance to use across application
    
    private var notificationSubscription: AnyCancellable?

    private let isLoggedInKey = "is-logged-in"
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isLoggedInKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isLoggedInKey)
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
    
    private let refreshTokenKey = "refresh-token"
    var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: refreshTokenKey)
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
    let preferredTermOptions = [
        "throne",
        "john",
        "crapper",
        "latrine",
        "washroom",
        "bathroom",
        "toilet",
        "restroom",
        "powder room",
        "comfort station",
        "water closet",
        "loo",
        "can"
    ]
    
    init() {
        notificationSubscription = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification).sink { _ in
            self.objectWillChange.send()
        }
    }
    
}
