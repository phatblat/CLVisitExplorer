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
    @IBOutlet private var startStopButton: UIButton!

    /// Indicates whether location updates are currently being delivered.
    private var monitoringLocation = false { didSet {
        guard monitoringLocation != oldValue else { return }
        defaults.set(monitoringLocation, forKey: Defaults.monitoringLocation.rawValue)
    } }

    private var defaults: UserDefaults { return UserDefaults.standard() }
}

private enum Defaults: String {
    case monitoringLocation
}

// MARK: - IBAction
extension ViewController {
    @IBAction func startStopButton(_ sender: UIButton) {
        monitoringLocation = !monitoringLocation
        debugPrint("startStopButton, monitoringLocation", monitoringLocation)
        toggleLocationMonitoring()
        toggleStartStopButton()
    }
}

// MARK: - UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        monitoringLocation = defaults.bool(forKey: Defaults.monitoringLocation.rawValue)
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
        if monitoringLocation {
            LocationManager.shared.start()
        } else {
            LocationManager.shared.stop()
        }
    }

    /// Updates the buttons display depending on the current monitoringLocation value.
    private func toggleStartStopButton() {
        var title: String
        if monitoringLocation {
            title = "Stop Monitoring Location"
        } else {
            title = "Start Monitoring Location"
        }
        startStopButton.setTitle(title, for: [])
    }
}
