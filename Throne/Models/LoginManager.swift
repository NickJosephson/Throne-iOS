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
        isLoggedOut = false
        showWelcomeScreen = false
    }
    
    @Published var isLoggedOut: Bool {
        didSet {
            if showWelcomeScreen != isLoggedOut {
                showWelcomeScreen = isLoggedOut
            }
        }
    }
    
    @Published var showWelcomeScreen: Bool {
        didSet {
            if showWelcomeScreen != isLoggedOut {
                showWelcomeScreen = isLoggedOut
            }
        }
    }
    
    func login() {
        isLoggedOut = false
    }
    
    func logout() {
        isLoggedOut = true
    }
}

