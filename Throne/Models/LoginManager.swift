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
    
    private let settings = PersistentSettings()
    private let authenticator = AuthenticationEndpoint()
    
    init() {
        let storedIsLoggedIn = PersistentSettings().isLoggedIn
        isLoggedIn = storedIsLoggedIn
        showWelcomeScreen = !storedIsLoggedIn
    }
    
    @Published var isLoggedIn: Bool {
        didSet {
            PersistentSettings().isLoggedIn = isLoggedIn
            
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
    
    func attemptLogin(with code: String) {
        authenticator.fetchTokens(authorizedWith: code) { tokens in
            DispatchQueue.main.async {
                self.settings.idToken = tokens.idToken
                self.settings.accessToken = tokens.accessToken
                self.settings.refreshToken = tokens.refreshToken
                self.isLoggedIn = true
            }
        }
    }
    
    func logout() {
        self.isLoggedIn = false
    }
}

