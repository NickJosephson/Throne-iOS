//
//  WashroomTest.swift
//  ThroneTests
//
//  Created by Nicholas Josephson on 2020-03-11.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest
@testable import Throne

class WashroomTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWebURL() {
        let washroom = Washroom()
        
        washroom.id = 0
        let url = washroom.webURL
        XCTAssertEqual(url.absoluteString, AppConfiguration.webAddress.absoluteString + "/washrooms/0")
        
        washroom.id = 123456
        let url2 = washroom.webURL
        XCTAssertEqual(url2.absoluteString, AppConfiguration.webAddress.absoluteString + "/washrooms/123456")
    }
    
    func testDistanceDescription() {
        let washroom = Washroom()
        var distanceDescription: String
        
        washroom.distance = nil
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "? m")
        
        washroom.distance = 0
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "0 m")
        
        washroom.distance = 0.1
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "0 m")
        
        washroom.distance = 100
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "100 m")
        
        washroom.distance = 100.9999
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "101 m")
        
        washroom.distance = 1100
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "1.1 km")
        
        washroom.distance = 10000.999999
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "10.0 km")
        
        washroom.distance = nil
        distanceDescription = washroom.distanceDescription
        XCTAssertEqual(distanceDescription, "? m")
    }
    
}
