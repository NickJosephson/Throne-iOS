//
//  LoginManagerTests.swift
//  ThroneTests
//
//  Created by Nicholas Josephson on 2020-02-17.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class LoginManagerTests: XCTestCase {
    var manager: LoginManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = LoginManager()
        manager.logout()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowWelcome() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(manager.isLoggedIn != manager.showWelcomeScreen)
        manager.logout()
        XCTAssert(manager.isLoggedIn != manager.showWelcomeScreen)
        manager.refreshLogin()
        XCTAssert(manager.isLoggedIn != manager.showWelcomeScreen)
    }

}
