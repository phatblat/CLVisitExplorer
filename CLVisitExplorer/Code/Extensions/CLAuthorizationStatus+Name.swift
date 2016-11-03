//
//  CLAuthorizationStatus+Name.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/29/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import CoreLocation

// MARK - CustomStringConvertible
extension CLAuthorizationStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notDetermined:         return "notDetermined"
        case .restricted:            return "restricted"
        case .denied:                return "denied"
        case .authorizedAlways:      return "authorizedAlways"
        case .authorizedWhenInUse:   return "authorizedWhenInUse"
        }
    }
}
