//
//  Place.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import RealmSwift

class Place: Object {
    dynamic var id = 0
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0
    dynamic var name = ""
    dynamic var streetAddress = ""
    dynamic var city = ""
    dynamic var state = ""
    dynamic var zip = ""
    dynamic var country = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
