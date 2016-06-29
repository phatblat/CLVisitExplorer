//
//  VisitTests.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/28/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

@testable import CLVisitExplorer
import XCTest

class VisitTests: XCTestCase {
    var visit: Visit!
    override func setUp() {
        super.setUp()
        visit = Visit()
    }
    
    override func tearDown() {
        visit = nil
        super.tearDown()
    }

    // MARK: - Tests
    func testUniqueId() {
        let visit2 = Visit()
        XCTAssertNotEqual(visit.id, visit2.id)
    }

    func testVisitDescription() {
        XCTAssertEqual(visit.description, "Arrival <0.0000,0.0000> +/-0m ")
    }

    func testDurationWhenBothNil() {
        XCTAssertNil(visit.duration)
    }

    func testDurationWhenArrivalNil() {
        visit.departureDate = Date()
        XCTAssertNil(visit.duration)
    }

    func testDurationOf30Seconds() {
        let now = Date()
        visit.departureDate = now
        visit.arrivalDate = Date(timeInterval: -30, since: now)
        XCTAssertNotNil(visit.duration)
        XCTAssertEqual(visit.duration, 30)
    }

    func testDurationComponents30Seconds() {
        let now = Date()
        visit.departureDate = now
        visit.arrivalDate = Date(timeInterval: -30, since: now)
        let dateComponents = visit.durationDateComponents
        XCTAssertNotNil(dateComponents)
        XCTAssertEqual(dateComponents!.second, 30)
    }
}
