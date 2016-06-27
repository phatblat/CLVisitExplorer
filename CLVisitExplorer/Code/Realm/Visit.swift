//
//  Visit.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import RealmSwift

// MARK: - Storage
class Visit: Object {
    dynamic var id = 0
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0

    /// The approximate time at which the user arrived at the specified location.
    dynamic var arrivalDate: Date?

    /// Time the arrival event was delivered to the app.
    dynamic var arrivalDeliveryDate: Date?

    /// The approximate time at which the user left the specified location.
    dynamic var departureDate: Date?

    /// Time the arrival event was delivered to the app.
    dynamic var departureDeliveryDate: Date?

    /// Optional user-supplied note for the visit.
    dynamic var note: String?
}

// MARK - RealmSwift.Object
extension Visit {
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Computed Properties
extension Visit {
    var coordinate: Coordinate {
        return Coordinate(latitude: latitude, longitude: longitude)
    }
}
