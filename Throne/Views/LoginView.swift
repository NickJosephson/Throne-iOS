//
//  LoginVIew.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import AuthenticationServices


/// SwiftUI containter for LoginViewController
struct LoginView: UIViewRepresentable {
    var controller: LoginViewController
    
    func makeUIView(context: Context) -> UIView {
        return controller.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}


/// A view to host a ASWebAuthenticationSession for allowing the user to log in
class LoginViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    private var session: ASWebAuthenticationSession!
    private var settings = PersistentSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ASWebAuthenticationPresentationContextProviding protocol method
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
    
    /// Present a webpage to login to Throne
    func startLogin() {
        startSession(at: AuthenticationEndpoint.loginAddress)
    }
    
    /// Present a webpage to signup to Throne
    func startSignup() {
        startSession(at: AuthenticationEndpoint.signupAddress)
    }

    /// Start a ASWebAuthenticationSession at the specified URL to login to Throne
    ///
    /// The authentication code that is returned by the session is used to initiat a login with the LoginManager
    private func startSession(at url: URL) {
        let scheme = "throne" // A ridirect to "throne://" will exit the session
        
        if let currentSession = session {
            currentSession.cancel()
        }
        
        session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else {
                print("ASWebAuthenticationSession failed: \(error.debugDescription)")
                return
            }
            
            guard let queryItems = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false)?.queryItems else {
                print("ASWebAuthenticationSession failed: No query items in callback URL.")
                return
            }
            
            guard let authenticationCode = queryItems.filter({ $0.name == "code" }).first?.value else {
                print("ASWebAuthenticationSession failed: No authentication code in callback URL.")
                return
            }
            
            DispatchQueue.main.async {
                LoginManager.shared.attemptLogin(with: authenticationCode)
            }
        }
        
        session.presentationContextProvider = self
        session.start()
    }
    
}
