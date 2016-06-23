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

    private var locationServicesEnabled: Bool {
        let enabled = CLLocationManager.locationServicesEnabled()
        if !enabled {
            debugPrint("Location services are disabled")
        }
        return enabled
    }

    deinit {
        clManager.delegate = nil
    }

    override init() {
        super.init()
        clManager.delegate = self
        clManager.activityType = .fitness
        clManager.desiredAccuracy = kCLLocationAccuracyKilometer
        clManager.distanceFilter = 50
        clManager.pausesLocationUpdatesAutomatically = true
    }
}

// MARK: - Internal API
extension LocationManager {
    /// Requests permission to use the user's location
    func requestPermission() {
        guard locationServicesEnabled else { return }
        clManager.requestAlwaysAuthorization()
        debugPrint("Location permission requested")
    }

    /// Starts up continuous location updates.
    func start() {
        guard locationServicesEnabled else { return }
        clManager.startUpdatingLocation()
        debugPrint("Location updates started")
    }

    /// Discontinues continuous location updates.
    func stop() {
        guard locationServicesEnabled else { return }
        clManager.stopUpdatingLocation()
        debugPrint("Location updates stopped")
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        debugPrint("didChangeAuthorization", status)
        if status == .authorizedAlways {
            clManager.allowsBackgroundLocationUpdates = true
        } else {
            debugPrint("Can't enable allowsBackgroundLocationUpdates because status was not .authorizedAlways")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) {
        debugPrint("didFailWithError", error)
    }

    /// Location updates delivered here
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("didUpdateLocations", locations)
    }
}
