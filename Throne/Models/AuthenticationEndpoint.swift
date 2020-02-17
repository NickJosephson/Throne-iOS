//
//  AuthenticationEndpoint.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-16.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Provides interaction with the AWS Cognito OAuth2 authentication interface for Throne
class AuthenticationEndpoint {
    private static let host = URL(string: "https://login.findmythrone.com")!
    private static let clientID = "7of5m2ips5c281ocb35neum748"
    private static let scope = "email+openid"
    private static let redirect = "throne://"
    
    /// URL of the AWS Cognito hosted login webpage
    class var loginAddress: URL {
        get {
            var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
            urlComponents.path = "/login"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id",     value: clientID),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope",         value: scope),
                URLQueryItem(name: "redirect_uri",  value: redirect)
            ]
            return urlComponents.url!
        }
    }
    
    /// URL of the AWS Cognito hosted signup webpage
    class var signupAddress: URL {
        get {
            var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
            urlComponents.path = "/signup"
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id",     value: clientID),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope",         value: scope),
                URLQueryItem(name: "redirect_uri",  value: redirect)
            ]
            return urlComponents.url!
        }
    }
    
    /// Asynchronously fetch id/access/refresh tokens.
    ///
    /// * The access token is needed to authenticate calls to the Throne API.
    /// * The refresh token is needed for fetching new access tokens (which expire frequently).
    /// - Parameters:
    ///   - code: The AWS authorization code returned from a user login.
    ///   - completionHandler: Handle the TokensResponse when fetching is finished.
    class func fetchTokens(authorizedWith code: String, completionHandler: @escaping (TokensResponse) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/oauth2/token"
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirect)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        performRequest(with: request) { data in
            if let tokensResponse = try? JSONDecoder().decode(TokensResponse.self, from: data) {
                completionHandler(tokensResponse)
            } else {
                print("Error decoding fetch tokens response.")
            }
        }
    }
    
    /// Asynchronously fetch a new access token.
    /// - Parameters:
    ///   - refreshToken: AWS Cognito refresh token from original fetchTokens() call.
    ///   - completionHandler: Handle the TokensResponse when fetching is finished.
    class func refreshTokens(authorizedWith refreshToken: String, completionHandler: @escaping (TokensResponse) -> Void) {
        var urlComponents = URLComponents(url: host, resolvingAgainstBaseURL: true)!
        urlComponents.path = "/oauth2/token"
        urlComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    
        performRequest(with: request) { data in
            if let tokensResponse = try? JSONDecoder().decode(TokensResponse.self, from: data) {
                completionHandler(tokensResponse)
            } else {
                print("Error decoding refresh tokens response.")
            }
        }
    }
    
    /// Represents tokens returned by AWS Cognito.
    struct TokensResponse: Codable {
        let idToken: String
        let accessToken: String
        let refreshToken: String?
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
