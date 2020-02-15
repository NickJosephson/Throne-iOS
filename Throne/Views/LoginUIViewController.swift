//
//  LoginUIViewController.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginUIViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    private var session: ASWebAuthenticationSession!
    private var settings = UserSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }

    func startLogin() {
        var authURL = URLComponents()
        authURL.host = "login.findmythrone.com"
        authURL.scheme = "https"
        authURL.path = "/login"
        authURL.queryItems = [
            URLQueryItem(name: "client_id",     value: "7of5m2ips5c281ocb35neum748"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope",         value: "email+openid"),
            URLQueryItem(name: "redirect_uri",  value: "throne://")
        ]
        
        startSession(at: authURL.url!)
    }
    
    func startSignup() {
        var authURL = URLComponents()
        authURL.host = "login.findmythrone.com"
        authURL.scheme = "https"
        authURL.path = "/signup"
        authURL.queryItems = [
            URLQueryItem(name: "client_id",     value: "7of5m2ips5c281ocb35neum748"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope",         value: "email+openid"),
            URLQueryItem(name: "redirect_uri",  value: "throne://")
        ]
        
        startSession(at: authURL.url!)
    }

    private func startSession(at url: URL) {
        let scheme = "throne"
        
        if let currentSession = session {
            currentSession.cancel()
        }
        
        session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { callbackURL, error in
            if callbackURL != nil {                
                if let fragment = callbackURL!.fragment {
                    let split = fragment.components(separatedBy: .init(charactersIn: "&="))

                    if let idTokenIndex = split.firstIndex(of: "id_token"), split.count > idTokenIndex {
                        self.settings.idToken = split[idTokenIndex + 1]
                    }

                    if let accessTokenIndex = split.firstIndex(of: "access_token"), split.count > accessTokenIndex {
                        self.settings.accessToken = split[accessTokenIndex + 1]
                    }
                    
                    LoginManager.sharedInstance.login()
                }
            }
        }
        
        session.presentationContextProvider = self
        session.start()
    }
    
}
