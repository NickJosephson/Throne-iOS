//
//  LoginManager.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class LoginManager: ObservableObject {
    static var sharedInstance = LoginManager()
    
    init() {
        let storedIsLoggedIn = UserSettings().isLoggedIn
        isLoggedIn = storedIsLoggedIn
        showWelcomeScreen = !storedIsLoggedIn
    }
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserSettings().isLoggedIn = isLoggedIn
            
            if showWelcomeScreen == isLoggedIn {
                showWelcomeScreen = !isLoggedIn
            }
        }
    }
    
    @Published var showWelcomeScreen: Bool {
        didSet {
            if showWelcomeScreen == isLoggedIn {
                showWelcomeScreen = !isLoggedIn
            }
        }
    }
    
    func login() {
        isLoggedIn = true
    }
    
    func logout() {
        isLoggedIn = false
    }
}

