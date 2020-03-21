//
//  WashroomDetailUITest.swift
//  ThroneUITests
//
//  Created by Nicholas Josephson on 2020-03-20.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class WashroomDetailUITest: XCTestCase {

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

    func testDetails() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.buttons["All Washrooms"].tap()
        tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].tap()
        XCTAssert(app.buttons["Add to favourites"].exists)
        XCTAssert(app.buttons["Review"].exists)
        XCTAssert(app.buttons["Share Washroom"].exists)
        XCTAssert(tablesQuery.staticTexts["Building 0"].exists)
    }
    
    func testReviews() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.buttons["All Washrooms"].tap()
        tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].tap()
        tablesQuery.buttons["Reviews\n0"].tap()
        
        XCTAssert(app.buttons["Review"].exists)
        XCTAssert(tablesQuery.staticTexts["No Reviews"].exists)
        
        app.navigationBars["Reviews"].buttons["Review"].tap()
        
        XCTAssert(tablesQuery.staticTexts["Cleanliness"].exists)
        XCTAssert(tablesQuery.staticTexts["Privacy"].exists)
        XCTAssert(tablesQuery.staticTexts["Paper Quality"].exists)
        XCTAssert(tablesQuery.staticTexts["Smell"].exists)
        
        let commentTextField = tablesQuery.textFields["Comment"]
        commentTextField.tap()
        commentTextField.typeText("test")
        app.navigationBars["New Review"].buttons["Post"].tap()
    }
    
    func testAmenities() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].tap()
        
        // add washroom
        app.navigationBars["Building 0"].buttons["Add Washroom"].tap()
        tablesQuery.buttons["Women's"].tap()
        tablesQuery.buttons["Air Dryer"].tap()
        tablesQuery.buttons["Paper Towel"].tap()
        tablesQuery.buttons["Automatic Dryer"].tap()
        app.navigationBars["New Washroom"].buttons["Add"].tap()
                
        // test that amenities are displayed
        tablesQuery.buttons["Women's Floor 1 \n0 m"].tap()
        tablesQuery.buttons["Amenities\nAir Dryer Paper Towel Automatic Dryer"].tap()
        XCTAssert(tablesQuery.staticTexts["Air Dryer"].exists)
        XCTAssert(tablesQuery.staticTexts["Paper Towel"].exists)
        XCTAssert(tablesQuery.staticTexts["Automatic Dryer"].exists)
        app.navigationBars["Amenities"].buttons["Back"].tap()
    }
}
