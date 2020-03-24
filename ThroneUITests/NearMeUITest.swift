//
//  NearMeUITest.swift
//  ThroneUITests
//
//  Created by Nicholas Josephson on 2020-03-20.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class NearMeUITest: XCTestCase {

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
    
    func testWashrooms() {
        let tablesQuery = XCUIApplication().tables
        
        // test washroom present in list
        tablesQuery.buttons["All Washrooms"].tap()
        XCTAssert(tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].exists)

        // test washroom present in list after switching to and from buildings
        tablesQuery.buttons["Buildings"].tap()
        tablesQuery.buttons["All Washrooms"].tap()
        XCTAssert(tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].exists)

        tablesQuery.buttons["Building 0\nInclusive Floor 0 \n0 m"].tap()
    }
    
    func testBuildings() {
        let tablesQuery = XCUIApplication().tables
        
        // test building present in list
        XCTAssert(tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].exists)
        
        // test building present in list after switching to and from all washrooms
        tablesQuery.buttons["All Washrooms"].tap()
        tablesQuery.buttons["Buildings"].tap()
        XCTAssert(tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].exists)
        
        tablesQuery.buttons["Building 0\n0 m\n5 Rooms"].tap()
    }
    
    func testFilter() {
        let app = XCUIApplication()
        app.navigationBars["Near Me"].buttons["Filter"].tap()
        
        // test functionality of amenity selector
        let tablesQuery = app.tables
        tablesQuery.buttons["Amenities\n0 Selected"].tap()
        tablesQuery.buttons["Air Dryer"].tap()
        tablesQuery.buttons["Paper Towel"].tap()
        tablesQuery.buttons["Automatic Dryer"].tap()
        app.navigationBars["Amenities"].buttons["Filter"].tap()

        // test that radius slider is present
        XCTAssert(tablesQuery.staticTexts["Radius"].exists)
        
        // test pressing showEmptyBuildings and reseting its state with Restore Defaults button
        let showEmptyBuildingsShowEmptyBuildingsSwitch = tablesQuery.switches["Show Empty Buildings"]
        XCTAssert(showEmptyBuildingsShowEmptyBuildingsSwitch.value as! String == "0")
        showEmptyBuildingsShowEmptyBuildingsSwitch.tap()
        XCTAssert(showEmptyBuildingsShowEmptyBuildingsSwitch.value as! String == "1")
        tablesQuery.buttons["Restore Defaults"].tap()
        XCTAssert(showEmptyBuildingsShowEmptyBuildingsSwitch.value as! String == "0")
        
        app.navigationBars["Filter"].buttons["Apply"].tap()
    }

}
