//
//  PlaceManager.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/26/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import CoreLocation
import RealmSwift

// MARK: - Storage
class PlaceManager {}

extension PlaceManager {
    func add(clVisit: CLVisit) {
        let visit = Visit()
        visit.latitude = clVisit.coordinate.latitude
        visit.longitude = clVisit.coordinate.longitude

        let now = Date()
        if clVisit.arrivalDate > Date.distantPast {
            visit.arrivalDate = clVisit.arrivalDate
            visit.arrivalDeliveryDate = now
        }
        if clVisit.departureDate > Date.distantPast {
            visit.departureDate = clVisit.departureDate
            visit.departureDeliveryDate = now
        }

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(visit)
            }
        } catch {
            print("Error saving visit: \(visit)")
        }

        NotificationHelper.notify(visit: visit)
    }
}
