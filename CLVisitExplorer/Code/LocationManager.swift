//
//  LocationManager.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import CoreLocation
import UIKit
import UserNotifications

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

    /// Convenience property for standard UserDefaults.
    private var defaults: UserDefaults { return UserDefaults.standard() }

    /// Indicates whether location updates are currently being delivered.
    var monitoringLocation = false { didSet {
        guard monitoringLocation != oldValue else { return }
        defaults.set(monitoringLocation, forKey: Defaults.monitoringLocation.rawValue)
    } }

    /// Indicates whether visits are currently being delivered.
    var monitoringVisits = false { didSet {
        guard monitoringVisits != oldValue else { return }
        defaults.set(monitoringVisits, forKey: Defaults.monitoringVisits.rawValue)
    } }

    deinit {
        clManager.delegate = nil
    }

    private override init() {
        super.init()
        clManager.delegate = self
        clManager.activityType = .fitness
        clManager.desiredAccuracy = kCLLocationAccuracyKilometer
        clManager.distanceFilter = 50
        clManager.pausesLocationUpdatesAutomatically = true

        monitoringLocation = defaults.value(forKey: .monitoringLocation)
        monitoringVisits = defaults.value(forKey: .monitoringVisits)
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

    /// Restarts any active location services. Used when app is launched 
    /// from an incoming location event.
    func restartLocationServices() {
        if monitoringLocation { startLocationUpdates() }
        if monitoringVisits { startVisitUpdates() }
    }

    /// Starts up continuous location updates.
    func startLocationUpdates() {
        guard locationServicesEnabled else { return }
        clManager.startUpdatingLocation()
        monitoringLocation = true
        debugPrint("Location updates started")
    }

    /// Discontinues continuous location updates.
    func stopLocationUpdates() {
        guard locationServicesEnabled else { return }
        clManager.stopUpdatingLocation()
        monitoringLocation = false
        debugPrint("Location updates stopped")
    }

    /// Starts up visit monitoring.
    func startVisitUpdates() {
        guard locationServicesEnabled else { return }
        clManager.startMonitoringVisits()
        monitoringVisits = true
        debugPrint("Visit monitoring started")
    }

    /// Stops visit monitoring.
    func stopVisitUpdates() {
        guard locationServicesEnabled else { return }
        clManager.stopMonitoringVisits()
        monitoringVisits = false
        debugPrint("Visit monitoring stopped")
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

    /// Interesting location visits are delivered here.
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        debugPrint("didVisit", visit)

//        if #available(iOS 10.0, *) {
//            let notification = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
//        } else {
            let notification = UILocalNotification()
            notification.alertTitle = "Visit"
            notification.alertBody = String(visit)
            UIApplication.shared().presentLocalNotificationNow(notification)
//        }
    }
}
