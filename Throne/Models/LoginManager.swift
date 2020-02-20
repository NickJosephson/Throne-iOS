//
//  LoginManager.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

/// Manage the state of user authentication and credentials.
final class LoginManager: ObservableObject {
    static var shared = LoginManager() // Shared instance to use across application

    private let settings = PersistentSettings()
    private var refreshAttempted = false // Only attempt token refresh once

    /// Whether the user is currently logged in.
    ///
    /// Logged in means the refresh token is currently believed to be valid.
    @Published private(set) var isLoggedIn: Bool {
        didSet {
            PersistentSettings().isLoggedIn = isLoggedIn
            
            if showWelcomeScreen == isLoggedIn {
                showWelcomeScreen = !isLoggedIn
            }
        }
    }
    
    /// Always reflects the opposite of isLoggedIn, even if set other wise.
    ///
    /// This is a workaround for the fact that SwiftUI sheets do not currently allow restricting the user from closing them.
    @Published var showWelcomeScreen: Bool {
        didSet {
            if showWelcomeScreen == isLoggedIn {
                showWelcomeScreen = !isLoggedIn
            }
        }
    }
    
    init() {
        // Restore login state
        let storedIsLoggedIn = PersistentSettings().isLoggedIn
        isLoggedIn = storedIsLoggedIn
        showWelcomeScreen = !storedIsLoggedIn
    }
    
    func logout() {
        if self.isLoggedIn {
            self.isLoggedIn = false
            self.settings.idToken = nil
            self.settings.accessToken = nil
            self.settings.refreshToken = nil
            
            NSLog("Log out completed.")
        }
    }
    
    func attemptLogin(with code: String) {
        AuthenticationEndpoint.fetchTokens(authorizedWith: code) { tokens in
            DispatchQueue.main.async {
                self.settings.idToken = tokens.idToken
                self.settings.accessToken = tokens.accessToken
                self.settings.refreshToken = tokens.refreshToken
                
                if self.verifyLogin() {
                    self.refreshAttempted = false
                    self.isLoggedIn = true
                    
                    NSLog("Login completed.")
                } else {
                    NSLog("Login error: Failed to verify access token.")
                }
            }
        }
    }
    
    /// - Todo: Verify access token works with Throne API
    private func verifyLogin() -> Bool {
        return true
    }
    
    /// Refresh the access token.
    ///
    /// This is needed if the access token has expired (usually after 60 minutes).
    /// If a refresh has already been attempted, a log out is performed.
    func refreshLogin() {
        if refreshAttempted {
            NSLog("Login refresh error: Already attempted, logging out.")
            logout()
            return
        }
        
        if let refreshToken = settings.refreshToken {
            refreshAttempted = true

            AuthenticationEndpoint.refreshTokens(authorizedWith: refreshToken) { tokens in
                DispatchQueue.main.async {
                    self.settings.idToken = tokens.idToken
                    self.settings.accessToken = tokens.accessToken
                    
                    if self.verifyLogin() {
                        self.refreshAttempted = false
                        self.isLoggedIn = true
                        
                        NSLog("Access token refreshed.")
                    } else {
                        NSLog("Login refresh error: Failed to verify new access token, logging out.")
                        self.logout()
                    }
                }
            }
        } else {
            NSLog("Login refresh error: No refresh token found, logging out.")
            logout()
        }
    }

}
