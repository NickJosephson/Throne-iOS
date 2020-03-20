//
//  BuildingTest.swift
//  ThroneTests
//
//  Created by Nicholas Josephson on 2020-03-11.
//  Copyright © 2020 Throne. All rights reserved.
//

import XCTest
@testable import Throne

class BuildingTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStars() {
        let building = Building()
        var stars: String //★ ☆
        
        building.overallRating = 0.0
        stars = building.stars
        XCTAssertEqual(stars, "")

        building.overallRating = -1.0
        stars = building.stars
        XCTAssertEqual(stars, "")
        
        building.overallRating = 0.25
        stars = building.stars
        XCTAssertEqual(stars, "☆☆☆☆☆")
        
        building.overallRating = 0.99
        stars = building.stars
        XCTAssertEqual(stars, "★☆☆☆☆")
        
        building.overallRating = 1.0
        stars = building.stars
        XCTAssertEqual(stars, "★☆☆☆☆")
        
        building.overallRating = 1.25
        stars = building.stars
        XCTAssertEqual(stars, "★☆☆☆☆")
        
        building.overallRating = 3.5
        stars = building.stars
        XCTAssertEqual(stars, "★★★★☆")
        
        building.overallRating = 5.0
        stars = building.stars
        XCTAssertEqual(stars, "★★★★★")
        
        building.overallRating = 12345
        stars = building.stars
        XCTAssertEqual(stars, "★★★★★")
    }
    
    func testDistanceDescription() {
        let building = Building()
        var distanceDescription: String
        
        building.distance = nil
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "? m")
        
        building.distance = 0
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "0 m")
        
        building.distance = 0.1
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "0 m")
        
        building.distance = 100
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "100 m")
        
        building.distance = 100.9999
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "101 m")
        
        building.distance = 1100
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "1.1 km")
        
        building.distance = 10000.999999
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "10.0 km")
        
        building.distance = nil
        distanceDescription = building.distanceDescription
        XCTAssertEqual(distanceDescription, "? m")
    }

}
