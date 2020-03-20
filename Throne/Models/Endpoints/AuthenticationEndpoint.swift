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
    #if STUBBED
        static let shared = AuthenticationEndpointStub()
    #else
        static let shared = AuthenticationEndpointStub()
    #endif
    
    private let host = AppConfiguration.authenticationLoginAddress
    private let clientID = AppConfiguration.authenticationClientID
    private let scope = AppConfiguration.authenticationScope
    private let redirect = AppConfiguration.authenticationLoginRedirect
    
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
    
    /// URL of the AWS Cognito hosted login webpage
    var loginAddress: URL {
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
    var signupAddress: URL {
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
    func fetchTokens(authorizedWith code: String, completionHandler: @escaping (TokensResponse?) -> Void) {
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
            if let data = data {
                if let tokensResponse = try? JSONDecoder().decode(TokensResponse.self, from: data) {
                    completionHandler(tokensResponse)
                } else {
                    NSLog("Error decoding fetch tokens response.")
                    completionHandler(nil)
                }
            } else {
                NSLog("Error fetching tokens.")
                completionHandler(nil)
            }
        }
    }
    
    /// Asynchronously fetch a new access token.
    /// - Parameters:
    ///   - refreshToken: AWS Cognito refresh token from original fetchTokens() call.
    ///   - completionHandler: Handle the TokensResponse when fetching is finished.
    func refreshTokens(authorizedWith refreshToken: String, completionHandler: @escaping (TokensResponse?) -> Void) {
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
            if let data = data {
                if let tokensResponse = try? JSONDecoder().decode(TokensResponse.self, from: data) {
                    completionHandler(tokensResponse)
                } else {
                    NSLog("Error decoding refresh tokens response.")
                    completionHandler(nil)
                }
            } else {
                NSLog("Error fetching refreshed tokens.")
                completionHandler(nil)
            }
        }
    }
    
    /// Fetch Data at a given URL.
    /// - Parameters:
    ///   - url: URL to send GET request to.
    ///   - completionHandler: Function to handle Data once received.
    private func fetch(url: URL, completionHandler: @escaping (Data?) -> Void) {
        let request = URLRequest(url: url)
        performRequest(with: request, completionHandler: completionHandler)
    }

    /// Perform a URLRequest with error handling.
    /// - Parameters:
    ///   - request: URLRequest to perform.
    ///   - completionHandler: Function to handle Data once received.
    private func performRequest(with request: URLRequest, completionHandler: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Authentication Endpoint URL Session Error: \(error)")
                completionHandler(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    NSLog("Authentication Endpoint URL Session Error: Unauthorized.")
                    completionHandler(nil)
                    return
                } else if !(200...299).contains(httpResponse.statusCode) {
                    NSLog("Authentication Endpoint URL Session Error: Unexpected status code \(httpResponse.statusCode))")
                    completionHandler(nil)
                    return
                }
            }

            if let data = data {
                completionHandler(data)
            }
        }

        task.resume()
    }
    
}
