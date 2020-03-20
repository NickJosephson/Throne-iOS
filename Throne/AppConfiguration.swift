//
//  AppConfiguration.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-19.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

/// Provide application wide constants customized for the current build scheme.
class AppConfiguration {
    static let authenticationLoginAddress = URL(string: "https://login.findmythrone.com")!
    static let authenticationLoginRedirect = "throne://"
    static let authenticationClientID = "7of5m2ips5c281ocb35neum748"
    static let authenticationScope = "email+openid"
    
    #if LOCAL
        static let apiAddress = URL(string: "http://localhost:5000")!
        static let webAddress = URL(string: "http://localhost:3000")!
    #elseif DEBUG
        static let apiAddress = URL(string: "https://api-dev.findmythrone.com")!
        static let webAddress = URL(string: "https://dev.findmythrone.com")!
    #else
        static let apiAddress = URL(string: "https://api-prod.findmythrone.com")!
        static let webAddress = URL(string: "https://app.findmythrone.com")!
    #endif
}
