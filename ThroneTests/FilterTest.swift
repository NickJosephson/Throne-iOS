//
//  FilterTest.swift
//  ThroneTests
//
//  Created by Nicholas Josephson on 2020-03-11.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest

class FilterTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRadiusDescription() {
        var filter = Filter()
        var radiusDescription: String
        
        filter.radius = 0.0
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "0 m")
        
        filter.radius = 0.001
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "1 m")
        
        filter.radius = 0.0001
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "0 m")
        
        filter.radius = 0.1
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "100 m")
        
        filter.radius = 0.999
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "999 m")
        
        filter.radius = 1000
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "1000.0 km")
        
        filter.radius = 1.9999
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "2.0 km")
        
        filter.radius = 1100.0
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "1100.0 km")
        
        filter.radius = 10000.999999
        radiusDescription = filter.radiusDescription
        XCTAssertEqual(radiusDescription, "10001.0 km")
    }

}
