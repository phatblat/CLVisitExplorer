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
    /// Adds a new Visit to the realm and posts a local notification.
    ///
    /// - parameter clVisit: A core location visito to copy data from.
    func add(_ clVisit: LocationVisit) {
        let visit = Visit()
        visit.latitude = clVisit.coordinate.latitude
        visit.longitude = clVisit.coordinate.longitude
        visit.horizontalAccuracy = clVisit.horizontalAccuracy

        let now = Date()
        if clVisit.arrivalDate > Date.distantPast {
            visit.arrivalDate = clVisit.arrivalDate
            visit.arrivalDeliveryDate = now
        }
        if clVisit.departureDate < Date.distantFuture {
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

        NotificationHelper.notify(visit)
    }

    /// Retrieves all Visits from the realm that are withing the diven delta of the coordinate.
    ///
    /// - parameter coordinate: Location to use for searching nearby Visits.
    /// - parameter delta:      The amount of tolerance in the latitude/longitude to consider a Visit "near".
    ///
    /// - returns: Array of Visit, empty if none were found.
    func visits(near coordinate: Coordinate, within delta: Double = 0.0001) -> Results<Visit> {
        let lowLat = coordinate.latitude - delta
        let highLat = coordinate.latitude + delta
        let lowLon = coordinate.longitude - delta
        let highLon = coordinate.longitude + delta
        let predicate = Predicate(format: "latitude BETWEEN {%f, %f} AND longitude BETWEEN {%f, %f}", lowLat, highLat, lowLon, highLon)

        do {
            let realm = try Realm()
            let closeVisits = realm.allObjects(ofType: Visit.self).filter(using: predicate)
            return closeVisits
        } catch {
            fatalError("Error querying visits: \(error)")
        }
    }
}
