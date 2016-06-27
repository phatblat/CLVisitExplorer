//
//  Visit.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import RealmSwift

class Visit: Object {
    dynamic var id = 0
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0
    dynamic var enterDate: Date?
    dynamic var enterDeliveryDate: Date?
    dynamic var exitDate: Date?
    dynamic var exitDeliveryDate: Date?
    dynamic var note: String?

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
