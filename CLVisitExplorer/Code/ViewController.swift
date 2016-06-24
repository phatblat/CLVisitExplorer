//
//  ViewController.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import MapKit
import UIKit

// MARK: - Storage
class ViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var locationButton: UIButton!
    @IBOutlet private var visitsButton: UIButton!

    /// Indicates whether location updates are currently being delivered.
    private var monitoringLocation: Bool { return LocationManager.shared.monitoringLocation }

    /// Indicates whether visits are currently being delivered.
    private var monitoringVisits: Bool { return LocationManager.shared.monitoringVisits }
}

// MARK: - IBAction
extension ViewController {
    @IBAction func didTapLocationButton(_ sender: UIButton) {
        debugPrint("didTapLocationButton, monitoringLocation", monitoringLocation)
        toggleLocationMonitoring()
        toggleLocationButton()
    }

    @IBAction func didTapVisitsButton(_ sender: UIButton) {
        debugPrint("didTapVisitsButton, monitoringVisits", monitoringVisits)
        toggleVisitMonitoring()
        toggleVisitsButton()
    }
}

// MARK: - UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if monitoringLocation { toggleLocationButton() }
        if monitoringVisits { toggleVisitsButton() }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.requestPermission()
    }
}

// MARK: - Private
private extension ViewController {
    /// Starts or stops location updates depending on the current monitoringLocation value.
    private func toggleLocationMonitoring() {
        !monitoringLocation
            ? LocationManager.shared.startLocationUpdates()
            : LocationManager.shared.stopLocationUpdates()
    }

    private func toggleVisitMonitoring() {
        !monitoringVisits
            ? LocationManager.shared.startVisitUpdates()
            : LocationManager.shared.stopVisitUpdates()
    }

    /// Updates the location button display depending on the current monitoringLocation value.
    private func toggleLocationButton() {
        let title = monitoringLocation
            ? "Stop Monitoring Location"
            : "Start Monitoring Location"
        locationButton.setTitle(title, for: [])
    }

    private func toggleVisitsButton() {
        let title = monitoringVisits
            ? "Stop Monitoring Visits"
            : "Start Monitoring Visits"
        visitsButton.setTitle(title, for: [])
    }
}
