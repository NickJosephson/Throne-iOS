//
//  AuthenticationEndpoint.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-16.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

class AuthenticationEndpoint {
    private let settings = PersistentSettings()
    
    func fetchTokens(authorizedWith code: String, completionHandler: @escaping (TokensResponse) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "throne.auth.us-east-1.amazoncognito.com"
        urlComponents.path = "/oauth2/token"
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "client_id", value: "7of5m2ips5c281ocb35neum748"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "throne://")
        ]

        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            performRequest(with: request) { data in
                if let tokensResponse = try? JSONDecoder().decode(TokensResponse.self, from: data) {
                    completionHandler(tokensResponse)
                }
            }
        }
    }
    
    struct TokensResponse: Codable {
        let idToken: String
        let accessToken: String
        let refreshToken: String
        let expiresIn: Int
        let tokenType: String
        
        private enum CodingKeys: String, CodingKey {
            case idToken = "id_token"
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
            case expiresIn = "expires_in"
            case tokenType = "token_type"
        }
    }
    
}
