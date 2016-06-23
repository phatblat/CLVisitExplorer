//
//  LocationManager.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import CoreLocation

// MARK: - Storage & Init
class LocationManager: NSObject {
    static let shared = LocationManager()
    private let clManager = CLLocationManager()

    deinit {
        clManager.delegate = nil
    }

    override init() {
        super.init()
        clManager.delegate = self
    }
}

// MARK: - Internal API
extension LocationManager {
    /// Requests permission to use the user's location
    func requestPermission() {
        clManager.requestAlwaysAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {}
