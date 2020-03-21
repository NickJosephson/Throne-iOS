//
//  ProfileUITest.swift
//  ThroneUITests
//
//  Created by Nicholas Josephson on 2020-03-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class ProfileUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEditButton() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        app.tabBars.buttons["Me"].tap()
        
        // test edit button
        XCTAssert(app.buttons["Edit"].exists)
        tablesQuery.buttons["My Reviews"].tap()
        XCTAssertFalse(app.buttons["Edit"].exists)
        tablesQuery.buttons["My Favorites"].tap()
        XCTAssert(app.buttons["Edit"].exists)
    }
    
    func testFavorite() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        app.tabBars.buttons["Me"].tap()
        
        // test no favorites
        XCTAssert(tablesQuery.staticTexts["No Washroom Favourited"].exists)
        
        // test add favorite
        app.tabBars.buttons["Near Me"].tap()
        tablesQuery.buttons["All Washrooms"].tap()
        tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].tap()
        app.buttons["Add to favourites"].tap()
        app.tabBars.buttons["Me"].tap()
        XCTAssert(tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].exists)
        
        // test remove favorite
        tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].swipeLeft()
        app.buttons["Delete"].tap()
        XCTAssert(tablesQuery.staticTexts["No Washroom Favourited"].exists)
    }

}
