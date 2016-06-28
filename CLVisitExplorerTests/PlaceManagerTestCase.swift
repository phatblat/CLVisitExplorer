//
//  PlaceManagerTestCase.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

@testable import CLVisitExplorer
import XCTest
import CoreLocation

class PlaceManagerTestCase: XCTestCase {
    var manager: PlaceManager!

    override func setUp() {
        super.setUp()
        manager = PlaceManager()
    }
    
    override func tearDown() {
        manager = nil
        super.tearDown()
    }

    func testAddVisit() {
        let clVisit = CLVisit()
//        clVisit.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        manager.add(clVisit)
    }
}
