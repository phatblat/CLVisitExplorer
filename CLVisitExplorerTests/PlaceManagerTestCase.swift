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
import RealmSwift

struct MockVisit: LocationVisit {
    var arrivalDate: Date
    var departureDate: Date
    var coordinate: CLLocationCoordinate2D
    var horizontalAccuracy: CLLocationAccuracy
}

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
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let visit = MockVisit(arrivalDate: Date(), departureDate: Date(), coordinate: coordinate, horizontalAccuracy: 10)
        manager.add(visit)
        let visits = manager.visits(near: coordinate)
        XCTAssertNotNil(visits)
        XCTAssertEqual(visits.count, 1)
    }
}
