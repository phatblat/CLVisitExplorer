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

    func testVisitDescription() {
        XCTAssertEqual(visit.description, "Arrival <0.0000,0.0000> +/-0m ")
    }
}
