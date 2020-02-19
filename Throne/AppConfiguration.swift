//
//  AppConfiguration.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-19.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

class AppConfiguration {
    static let authenticationLoginAddress = URL(string: "https://login.findmythrone.com")!
    static let authenticationLoginRedirect = "throne://"
    static let authenticationClientID = "7of5m2ips5c281ocb35neum748"
    static let authenticationScope = "email+openid"
    
    #if LOCAL
        static let apiAddress = URL(string: "https://localhost:5000")!
    #elseif DEBUG
        static let apiAddress = URL(string: "https://api-dev.findmythrone.com")!
    #else
        static let apiAddress = URL(string: "https://api-prod.findmythrone.com")!
    #endif
}
