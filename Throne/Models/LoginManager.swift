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
    static var shared = LoginManager()
    
    private let settings = PersistentSettings()
    private var refreshAttempted = false
    
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
    
    func logout() {
        if self.isLoggedIn {
            self.isLoggedIn = false
            self.settings.idToken = nil
            self.settings.accessToken = nil
            self.settings.refreshToken = nil
        }
    }
    
    func attemptLogin(with code: String) {
        AuthenticationEndpoint.fetchTokens(authorizedWith: code) { tokens in
            DispatchQueue.main.async {
                self.settings.idToken = tokens.idToken
                self.settings.accessToken = tokens.accessToken
                self.settings.refreshToken = tokens.refreshToken
                self.verifyLogin()
            }
        }
    }
    
    private func verifyLogin() {
        //verify credentials
        
        self.refreshAttempted = false
        self.isLoggedIn = true
    }
    
    func refreshLogin() {
        if refreshAttempted {
            print("Already attempted login refresh, logging out.")
            logout()
            return
        }
        
        if let refreshToken = settings.refreshToken {
            refreshAttempted = true

            AuthenticationEndpoint.refreshTokens(authorizedWith: refreshToken) { tokens in
                DispatchQueue.main.async {
                    self.settings.idToken = tokens.idToken
                    self.settings.accessToken = tokens.accessToken
                    self.verifyLogin()
                }
            }
        } else {
            print("No refresh token found, logging out.")
            logout()
        }
    }
    

}

