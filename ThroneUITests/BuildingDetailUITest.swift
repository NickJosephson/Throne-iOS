//
//  BuildingDetailUITest.swift
//  ThroneUITests
//
//  Created by Nicholas Josephson on 2020-03-20.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class BuildingDetailUITest: XCTestCase {

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

    func testWashroomsInside() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        // test first washroom is present
        tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].tap()
        tablesQuery.buttons["Inclusive Floor 0 \n0 m"].tap()
        app.navigationBars.buttons["Building 0"].tap()

        // test last washroom is present
        tablesQuery.buttons["Inclusive Floor 4 \n0 m"].tap()
        app.navigationBars.buttons["Building 0"].tap()
    }
    
    func testAddWashroom() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].tap()
        
        app.navigationBars["Building 0"].buttons["Add Washroom"].tap()
        tablesQuery.buttons["Women's"].tap()
        tablesQuery.buttons["Men's"].tap()
        XCTAssert(tablesQuery.otherElements["Floor"].exists)
        XCTAssert(tablesQuery.otherElements["Stalls"].exists)
        XCTAssert(tablesQuery.otherElements["Urinals"].exists)
        XCTAssert(tablesQuery.textFields["Additional Description"].exists)
        
        tablesQuery.buttons["Air Dryer"].tap()
        tablesQuery.buttons["Paper Towel"].tap()
        tablesQuery.buttons["Automatic Dryer"].tap()
        tablesQuery.buttons["Automatic Paper Towel"].tap()
        app.navigationBars["New Washroom"].buttons["Add"].tap()
        
        // test new washroom is present
        tablesQuery.buttons["Men's Floor 1 \n0 m"].tap()
        app.navigationBars.buttons["Building 0"].tap()
    }

}
