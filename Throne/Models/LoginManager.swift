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

    private let settings = PersistentSettings.shared
    private var refreshSubscription: AnyCancellable!
    private var currentUserSubscription: AnyCancellable!

    var requestRefresh = PassthroughSubject<Void, Never>()
    var requestUserFetch = PassthroughSubject<Void, Never>()
    var refreshCompleted = PassthroughSubject<Void, Never>()
    var loginCompleted = PassthroughSubject<Void, Never>()

    @Published private(set) var currentUser: User?
    
    /// Whether the user is currently logged in.
    ///
    /// Logged in means the refresh token is currently believed to be valid.
    @Published private(set) var isLoggedIn: Bool {
        didSet {
            settings.isLoggedIn = isLoggedIn
        }
    }
    
    init() {
        // Restore login state
        isLoggedIn = settings.isLoggedIn
        
        // refresh token when a refresh is requested
        refreshSubscription = requestRefresh
            .throttle(for: .seconds(60), scheduler: RunLoop.current, latest: false)
            .sink {
                self.refreshLogin()
            }
        
        // create publisher for indicating when to perform current user update
        let shouldUpdatePublisher = self.loginCompleted
            .merge(with: self.refreshCompleted, self.requestUserFetch)
          .eraseToAnyPublisher()

        currentUserSubscription = shouldUpdatePublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchCurrentUser { user in
                        promise(.success(user))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.currentUser, on: self)
    }
    
    func logout() {
        if self.isLoggedIn {
            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.settings.idToken = nil
                self.settings.accessToken = nil
                self.settings.refreshToken = nil
                self.currentUser = nil
                
                NSLog("Log out completed.")
            }
        }
    }
    
    func attemptLogin(with code: String) {
        AuthenticationEndpoint.fetchTokens(authorizedWith: code) { tokens in
            DispatchQueue.main.async {
                if let tokens = tokens {
                    self.settings.idToken = tokens.idToken
                    self.settings.accessToken = tokens.accessToken
                    self.settings.refreshToken = tokens.refreshToken
                                        
                    self.isLoggedIn = true
                    self.loginCompleted.send()
                    NSLog("Login completed.")
                } else {
                    NSLog("Login error: Failed to fetch access token.")
                }
            }
        }
    }

    /// Refresh the access token.
    ///
    /// This is needed if the access token has expired (usually after 60 minutes).
    /// If a refresh has already been attempted, a log out is performed.
    func refreshLogin() {
        NSLog("Starting login refresh.")
        if let refreshToken = settings.refreshToken {
            AuthenticationEndpoint.refreshTokens(authorizedWith: refreshToken) { tokens in
                DispatchQueue.main.async {
                    if let tokens = tokens {
                        self.settings.idToken = tokens.idToken
                        self.settings.accessToken = tokens.accessToken
                        
                        NSLog("Access token refreshed.")
                        self.refreshCompleted.send()
                    } else {
                        NSLog("Login refresh error: Failed to fetch new access token, logging out.")
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
