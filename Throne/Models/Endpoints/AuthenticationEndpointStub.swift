//
//  AuthenticationEndpointStub.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-20.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

internal class AuthenticationEndpointStub: AuthenticationEndpoint {
    override func fetchTokens(authorizedWith code: String, completionHandler: @escaping (TokensResponse?) -> Void) {
        completionHandler(TokensResponse(idToken: "0", accessToken: "0", refreshToken: "0", expiresIn: 3600, tokenType: "Bearer"))
    }

    override func refreshTokens(authorizedWith refreshToken: String, completionHandler: @escaping (TokensResponse?) -> Void) {
        completionHandler(TokensResponse(idToken: "0", accessToken: "0", refreshToken: "0", expiresIn: 3600, tokenType: "Bearer"))
    }
}
