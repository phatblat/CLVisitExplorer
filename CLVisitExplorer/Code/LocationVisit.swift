//
//  LocationVisit.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/28/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import CoreLocation

/// Protocol matching the interface of `CLVisit` for this app to use
/// and to enable testing.
protocol LocationVisit {
    var arrivalDate: Date { get }
    var departureDate: Date { get }
    var coordinate: CLLocationCoordinate2D { get }
    var horizontalAccuracy: CLLocationAccuracy { get }
}

extension CLVisit: LocationVisit {}
