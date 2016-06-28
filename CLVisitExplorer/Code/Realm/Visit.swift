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

    /// The horizontal accuracy (in meters) of the specified coordinate.
    dynamic var horizontalAccuracy: Double = 0

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

    /// Used to format arrival date and time.
    private lazy var arrivalDateFormatter: DateFormatter = {
        //$0.dateStyle = .mediumStyle
        //$0.timeStyle = .shortStyle
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return $0
    }(DateFormatter())

    /// Used to format departure time.
    private lazy var departureDateFormatter: DateFormatter = {
        $0.dateStyle = .noStyle
        $0.timeStyle = .mediumStyle // 3:30:32 PM
//        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return $0
    }(DateFormatter())

    private lazy var durationFormatter: DateComponentsFormatter = {
//        NSDateComponentsFormatterUnitsStyle
//        Short	“1hr 10min”
        $0.unitsStyle = .short
        return $0
    }(DateComponentsFormatter())
}

// MARK - RealmSwift.Object
extension Visit {
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Computed Properties
extension Visit {
    /// Packages up latitude and longitude into a convenient struct compatible with `CLLocationCoordinate2D`.
    var coordinate: Coordinate {
        return Coordinate(latitude: latitude, longitude: longitude)
    }

    /// Classifyes a visit event.
    ///
    /// - Arrival:   Visit with only an arrival time.
    /// - Departure: Visit with a departure time.
    enum VisitType: String {
        case Arrival, Departure
    }

    /// Determines which type of a visit.
    var type: VisitType {
        return (departureDate == nil) ? .Arrival : .Departure
    }

    var duration: DateComponents? {
        guard let departure = departureDate else { return nil }
        return Calendar.current().components([.day, .hour, .minute, .second], from: departure)
    }
}

// MARK: - CustomStringConvertible
extension Visit {
    override var description: String {
        var time: String = ""
        if let arrival = arrivalDate {
            time = arrivalDateFormatter.string(from: arrival)
        }
        if let departure = departureDate {
            time += " - "
            time += departureDateFormatter.string(from: departure)
            time += " "
            time += durationFormatter.string(from: duration!)!
        }

        return String(format: "%@ <%.4f,%.4f> +/-%.0fm %@", type.rawValue, latitude, longitude, horizontalAccuracy, time)
    }
}
