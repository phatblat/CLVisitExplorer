//
//  ViewController.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import UIKit

// MARK: - Storage
class ViewController: UIViewController {
    @IBOutlet private var startStopLocationButton: UIButton!
    @IBOutlet private var startStopVisitsButton: UIButton!

    /// Indicates whether location updates are currently being delivered.
    private var monitoringLocation = false { didSet {
        guard monitoringLocation != oldValue else { return }
        defaults.set(monitoringLocation, forKey: Defaults.monitoringLocation.rawValue)
    } }

    /// Indicates whether visits are currently being delivered.
    private var monitoringVisits = false { didSet {
        guard monitoringVisits != oldValue else { return }
        defaults.set(monitoringVisits, forKey: Defaults.monitoringVisits.rawValue)
    } }

    private var defaults: UserDefaults { return UserDefaults.standard() }
}

// MARK: - IBAction
extension ViewController {
    @IBAction func didTapLocationButton(_ sender: UIButton) {
        monitoringLocation = !monitoringLocation
        debugPrint("startStopButton, monitoringLocation", monitoringLocation)
        toggleLocationMonitoring()
        toggleLocationButton()
    }

    @IBAction func didTapVisitsButton(_ sender: UIButton) {
        monitoringVisits = !monitoringVisits
        debugPrint("startStopButton, monitoringVisits", monitoringVisits)
        toggleVisitMonitoring()
        toggleVisitsButton()
    }
}

// MARK: - UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitoringLocation = defaults.bool(forKey: Defaults.monitoringLocation.rawValue)
        monitoringVisits = defaults.bool(forKey: Defaults.monitoringVisits.rawValue)
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
        monitoringLocation
            ? LocationManager.shared.startLocationUpdates()
            : LocationManager.shared.stopLocationUpdates()
    }

    private func toggleVisitMonitoring() {
        monitoringVisits
            ? LocationManager.shared.startVisitUpdates()
            : LocationManager.shared.stopVisitUpdates()
    }

    /// Updates the location button display depending on the current monitoringLocation value.
    private func toggleLocationButton() {
        let title = monitoringLocation
            ? "Stop Monitoring Location"
            : "Start Monitoring Location"
        startStopLocationButton.setTitle(title, for: [])
    }

    private func toggleVisitsButton() {
        let title = monitoringVisits
            ? "Stop Monitoring Visits"
            : "Start Monitoring Visits"
        startStopVisitsButton.setTitle(title, for: [])
    }
}
